from flask import Flask, render_template, request, session , redirect
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
from datetime import datetime
from werkzeug import secure_filename
import json
import os
from math import ceil
import secrets

with open('config.json', 'r') as c:
    params = json.load(c)["params"]

local_server = True
app = Flask(__name__)
app.config['UPLOAD'] = params['upload_location']
app.secret_key = 'super key'
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params['gmail-user'],
    MAIL_PASSWORD = params['gmail-password']  )

mail = Mail(app)
if (local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']          #connecting with database
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']

db = SQLAlchemy(app)


class Contacts(db.Model):                                                           # define tables of database

    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80),  nullable=False)
    email = db.Column(db.String(120),  nullable=False)
    phone_no = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(120), nullable=True)
    msg = db.Column(db.String(20),  nullable=False)

class Post(db.Model):

    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(21), nullable=False)
    content = db.Column(db.String(150), nullable=False)
    tagline = db.Column(db.String(50), nullable=False)
    date = db.Column(db.String(20), nullable=True)
    img_file = db.Column(db.String(50), nullable=True)

@app.route("/")
def home():
    posts = Post.query.filter_by().all()
    last = ceil(len(posts)/int(params['no_of_posts']))  #total number of post divided by number of post i want to show in a page

    page = request.args.get("page")  #created a page variable
    if (not str(page).isnumeric()):   # if page is not number then set it page=1
        page = 1

    page = int(page)

    posts = posts[(page-1)*int(params["no_of_posts"]):(page - 1)*int(params["no_of_posts"])+int(params["no_of_posts"])]  # [0 : 3]

    if page == 1:
        prev = "#"
        next = "/?page=" + str(page+1)
    elif page == last :
        next = "#"
        prev = "/?page=" + str(page - 1)
    else:
        prev = "/?page=" + str(page - 1)
        next = "/?page=" + str(page + 1)

    return render_template('index.html', params=params, post=posts, prev=prev, next = next)

@app.route("/about")
def about():
    return render_template('about.html', params=params)

@app.route("/uploader", methods = ['POST','GET'] )
def uploader():
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method == 'POST':
            f=request.files['file1']
            f.save(os.path.join(app.config['UPLOAD'], secure_filename(f.filename) ))
            return "uploaded succesfully"

@app.route("/logout")
def logout():
    session.pop('user')
    return redirect("/login")

@app.route("/delete/<string:sno>", methods = ['GET','POST'])
def delete(sno):
    if 'user' in session and session['user'] == params['admin_user']:
        post = Post.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect("/login")




@app.route("/edit/<string:sno>", methods = ['POST','GET'] )
def edit(sno):
    if 'user' in session and session['user'] == params['admin_user']:

        if request.method == 'POST':

            box_title = request.form.get('title')
            tagline = request.form.get('tline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            date = datetime.now()

            if sno == '0':          #start adding new post to database
                post = Post(title = box_title , tagline = tagline , slug = slug , content=content , img_file = img_file,date = date)
                db.session.add(post)
                db.session.commit()

            else:                   # retrieving the already present content
                post = Post.query.filter_by(sno=sno).first()
                post.title = box_title
                post.tagline = tagline
                post.slug = slug
                post.content = content
                post.img_file = img_file
                post.date = date
                db.session.commit()
                return redirect('/edit/' + sno)
        post = Post.query.filter_by(sno=sno).first()
        return render_template('edit.html', params=params, post=post)


@app.route("/login", methods = ['POST' , 'GET'])
def login():
    # if user is already logged in
    if 'user' in session and session['user'] == params['admin_user']:
        p = Post.query.all()                                            # fetch all the posts
        return render_template('dashboard.html',params=params , post=p)   #go to dashboard


    #if not already logged in , then log in
    if request.method == 'POST':
        username = request.form.get('uname')   #'uname' is written in form block of html
        userpass = request.form.get('pass')    #'pass' is written in form block of html
        if username == params['admin_user'] and userpass == params['admin_password']: #checking id and pass is correct or not

            #set session variable
            session['user'] = username  #meaning user is logged in
            p = Post.query.all()
            return render_template('dashboard.html', params = params, post = p)

    return render_template('login.html', params=params)

@app.route("/contact", methods= ['POST','GET'])
def contact():
    if request.method == 'POST':
        #add entry to database
        name = request.form.get('name')
        # LHS is user defined name and
        # RHS (name inside bracket)name should match with the html name
        email_id = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('msg')

        #fetching values from database

        entry = Contacts(name = name,email = email_id ,date = datetime.now(), phone_no = phone, msg = message )
        #lhs is database name and rhs is above used name

        db.session.add(entry)
        db.session.commit()
        mail.send_message('new message from ' + name ,
                          sender = email_id ,
                          recipients = [params['gmail-user']],
                          body = message + "\n" + phone
                          )

    return render_template('contact.html', params=params)

@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    return render_template('post.html', params=params, post = Post.query.filter_by(slug=post_slug).first())


if __name__ == '__main__':
    app.run(debug=True)