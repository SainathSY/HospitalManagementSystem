from flask import Flask,render_template,request,session,redirect,url_for,flash
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from werkzeug.security import generate_password_hash,check_password_hash
from flask_login import login_user,logout_user,login_manager,LoginManager
from flask_login import login_required,current_user
from flask_mail import Mail
from datetime import date
from datetime import datetime
import json
from keras.models import load_model
import numpy as np
from keras.applications.vgg16 import preprocess_input
import os
from flask_pymongo import PyMongo
from flask import Flask
from pymongo import MongoClient
import os
import cv2


# MY db connection
local_server= True
app = Flask(__name__)
app.secret_key='SaiSam'


# this is for getting unique user access
login_manager=LoginManager(app)
login_manager.login_view='login'




@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))




# app.config['SQLALCHEMY_DATABASE_URL']='mysql://username:password@localhost/databas_table_name'
app.config['SQLALCHEMY_DATABASE_URI']='mysql://root:@localhost/hmdbms_sample'
db=SQLAlchemy(app)


client = MongoClient('mongodb://localhost:27017/')
db1 = client['HMS']
collection = db1['mycollection']


# here we will create db models that is tables



class User(UserMixin,db.Model):
    id=db.Column(db.Integer,primary_key=True)
    firstname=db.Column(db.String(50))
    midname=db.Column(db.String(50))
    lastname=db.Column(db.String(50))
    usertype=db.Column(db.String(50))
    email=db.Column(db.String(50),unique=True)
    password=db.Column(db.String(1000))

class Patient(db.Model):
    pid=db.Column(db.Integer,db.ForeignKey('user.id'))
    firstname=db.Column(db.String(50))
    midname=db.Column(db.String(50))
    lastname=db.Column(db.String(50))
    email=db.Column(db.String(50),primary_key=True)
   

class Patients(db.Model):
    pid=db.Column(db.Integer,db.ForeignKey('user.id'),primary_key=True)
    did=db.Column(db.Integer,db.ForeignKey('user.id'))
    email=db.Column(db.String(50))
    firstname=db.Column(db.String(50))
    midname=db.Column(db.String(50))
    lastname=db.Column(db.String(50))
    gender=db.Column(db.String(50))
    slot=db.Column(db.String(50),primary_key=True)
    disease=db.Column(db.String(50))
    #time=db.Column(db.Time,nullable=False)
    date=db.Column(db.Date,nullable=False,primary_key=True)
    dept=db.Column(db.String(50))
    

class Doctors(db.Model):
    did=db.Column(db.Integer,db.ForeignKey('user.id'))
    email=db.Column(db.String(50),primary_key=True)
    firstname=db.Column(db.String(50))
    midname=db.Column(db.String(50))
    lastname=db.Column(db.String(50))
    dept=db.Column(db.String(50))

class Trigr(db.Model):
    tid=db.Column(db.Integer,primary_key=True)
    pid=db.Column(db.Integer,db.ForeignKey('user.id'))
    email=db.Column(db.String(50))
    firstname=db.Column(db.String(50))
    midname=db.Column(db.String(50))
    lastname=db.Column(db.String(50))
    action=db.Column(db.String(50))
    timestamp=db.Column(db.DateTime,nullable=False)
    
class Presc(db.Model):
    pid=db.Column(db.Integer,db.ForeignKey('user.id'),primary_key=True)
    did=db.Column(db.Integer,db.ForeignKey('user.id'),primary_key=True)
    date=db.Column(db.Date,nullable=False,primary_key=True)
    Medicine_Name=db.Column(db.String(20),primary_key=True)
    dosage=db.Column(db.String(30))
    number_of_days=db.Column(db.Integer)
    Note_to_patient=db.Column(db.String(30))



class Nurse(db.Model):
    nid=db.Column(db.Integer,db.ForeignKey('user.id'))
    email=db.Column(db.String(50),primary_key=True)
    firstname=db.Column(db.String(50))
    midname=db.Column(db.String(50))
    lastname=db.Column(db.String(50))
   
    
class Cashier(db.Model):
    cid=db.Column(db.Integer,db.ForeignKey('user.id'))
    email=db.Column(db.String(50),primary_key=True)
    firstname=db.Column(db.String(50))
    midname=db.Column(db.String(50))
    lastname=db.Column(db.String(50))
    
    


class Billing(db.Model):
    pid=db.Column(db.Integer,db.ForeignKey('user.id'),primary_key=True)
    date=db.Column(db.Date,nullable=False,primary_key=True)
    Medicine_Name=db.Column(db.String(20),primary_key=True)
    price=db.Column(db.Integer)
    quantity=db.Column(db.Integer)
    totalprice=db.Column(db.Integer)
    paymentstatus=db.Column(db.String(20))


# here we will pass endpoints and run the fuction
@app.route('/')
def index():
    return render_template('index.html')




# Alzheimer ----------------------------------------------------------------

model = load_model('PROJECT/cvalzheimers.h5')
target_img = os.path.join(os.getcwd() ,'static/images/alzheimer')



ALLOWED_EXT = set(['JPG' ,'jpg', 'jpeg' , 'png'])
def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1] in ALLOWED_EXT
           
# Function to load and prepare the image in right shape
def read_image(filename):
    
    img = cv2.imread(filename)
    img = cv2.resize(img,(150,150))
    img_array = np.array(img)
    img_array = img_array.reshape(1,150,150,3)
    return img_array




@app.route('/alzheimerpredict',methods=['GET','POST'])
def alzheimerpredict():
      
      ref={0: 'MildDemented',
      1: 'ModerateDemented',
      2: 'NonDemented',
      3: 'VeryMildDemented',
     }
      
      if request.method == 'POST':
          file = request.files['file']
          
          if file and allowed_file(file.filename):
                filename = file.filename
                file_path = os.path.join('PROJECT/static/images/alzheimer/', filename)
                file.save(file_path)

                img = read_image(file_path)

                # Make the prediction
                answer = model.predict(img)

                # Get the class label with the highest probability
                d = ref[np.argmax(answer)]

                # Calculate the probability of the class label
                probability = round(np.max(answer) * 100, 2)

                return render_template('alzheimerpredict.html', disease=d, prob=probability, user_image=file_path)

              
          else:
            return "Unable to read the file. Please check file extension"
    
      return render_template('alzheimerpredict.html')
    

#----------------------------------------------------------------



#Feedback template for NOSQL integration----------------------------------------------------------------

@app.route('/feedback', methods=['GET', 'POST'])
def feeedback():
    now = datetime.now()
    if request.method == 'POST':
        
        data = {
            'did': request.form['did'],
            'feedback': request.form['feedback'], 
            'timestamp': now
        }
        collection.insert_one(data)
        flash("Thanks for your feedback","info")
    return render_template('feedbackform.html')


@app.route('/doctor_feedback', methods=['GET', 'POST'])
def doctor_feeedback():
    did=str(current_user.id)
    data = collection.find({'did': did}).sort('timestamp')
    result = []
    for item in data:
        item['timestamp'] = item['timestamp'].strftime("%m/%d/%Y, %H:%M:%S")
        result.append(item)
    result.reverse()
    #print(result)
    
    return render_template('feedback_display.html', data=result)
    

#------------------------------------------------------------------------------




@app.route('/doctors',methods=['POST','GET'])
def doctors():

    if request.method=="POST":

        email=request.form.get('email')
        doctorname=request.form.get('doctorname')
        dept=request.form.get('dept')

        #query=db.engine.execute(f"INSERT INTO `doctors` (`email`,`doctorname`,`dept`) VALUES ('{email}','{doctorname}','{dept}')")
        flash("Information is Stored","primary")

    return render_template('doctor.html')


    

#Doctor prescribing medicine----------------------------------------------------------------


@app.route('/presc',methods=['POST','GET'])
def presc():
    if request.method=="POST":
        pid=request.form.get('pid')
        #patientname=request.form.get('patientname')
        date=request.form.get('date')
        Medicine_Name=request.form.get('Medicine_Name')
        dosage=request.form.get('dosage')
        number_of_days=request.form.get('number_of_days')
        Note_to_patient=request.form.get('Note_to_patient')
            
        if pid:
            did=current_user.id
            db.engine.execute(f"INSERT INTO `presc`(`did`,`pid`,`date`,`Medicine_Name`,`dosage`,`number_of_days`,`Note_to_patient`) VALUES ('{did}','{pid}','{date}','{Medicine_Name}','{dosage}','{number_of_days}','{Note_to_patient}')")
            
            flash("Information is Stored","primary")
            # if 'btn1' in request.form:
            #          return redirect("/bookings")
                
            # elif 'btn' in request.form:
            #          return redirect("/bookings")
        
    return render_template('presc.html')
 
   
@app.route('/prescription_details/<string:dept>',methods=['POST','GET'])
def prescription_details(dept):  

    query=db.engine.execute(f"SELECT * FROM `doctors` WHERE `dept`='{dept}'")
    list=[post.did for post in query]
    did=list[0]
    firstname=current_user.firstname
    midname=current_user.midname
    lastname=current_user.lastname
    posts=db.engine.execute(f"SELECT * FROM `presc` where `pid`={current_user.id} and `did` ='{did}'")
    #SELECT * FROM `presc` where `pid`={current_user.id} and `did` =(select did from `doctors` where `dept`={dept}) 
    return render_template('prescription_details.html',posts=posts,firstname=firstname,midname=midname,lastname=lastname)

@app.route('/prescription_details_doctor/<int:pid>',methods=['POST','GET'])
def prescription_details_doctor(pid):  

    query=db.engine.execute(f"SELECT * FROM `patient` WHERE `pid`='{pid}'")
    list=[post for post in query]
    patient_data=list[0]
    firstname=patient_data.firstname
    midname=patient_data.midname
    lastname=patient_data.lastname
    posts=db.engine.execute(f"SELECT * FROM `presc` where `did`={current_user.id} and `pid` ='{pid}'")
    #SELECT * FROM `presc` where `pid`={current_user.id} and `did` =(select did from `doctors` where `dept`={dept}) 
    return render_template('prescription_details.html',posts=posts,firstname=firstname,midname=midname,lastname=lastname)

#----------------------------------------------------------------



#Patient checking prescription-----------------------------------------------------------------


@app.route('/patient_prescription',methods=['POST','GET'])
def patient_prescription():
    doct=db.engine.execute("SELECT * FROM `doctors`")
    if request.method=="POST":
        dept=request.form.get('dept')
        return redirect(url_for('prescription_details',dept=dept))
        
    return render_template('patient_prescription.html',doct=doct)

#------------------------------------------------------------------------------



#Doctor checking prescription-----------------------------------------------------------------

@app.route('/doctor_prescription',methods=['POST','GET'])
def doctor_prescription():
    #doct=db.engine.execute("SELECT * FROM `doctors`")
    if request.method=="POST":
        pid=request.form.get('pid')
        return redirect(url_for('prescription_details_doctor',pid=pid))
        
    return render_template('doctor_prescription.html')


#------------------------------------------------------------------------------





#Billing by cashier and viewing by both cashier and patient----------------------------------------------------------------


@app.route('/billing_filling',methods=['POST','GET'])
def billing_filling():  
    
    
    if request.method=="POST":
        pid=request.form.get('pid')
        date=request.form.get('date')
        Medicine_Name=request.form.get('Medicine_Name')
        price=request.form.get('price')
        quantity=request.form.get('quantity')
        totalprice=int(price)*int(quantity)
        paymentstatus=request.form.get('paymentstatus')

        if pid:
            db.engine.execute(f"INSERT INTO `billing`(`pid`,`date`,`Medicine_Name`,`price`,`quantity`,`totalprice`,`paymentstatus`) VALUES ('{pid}','{date}','{Medicine_Name}','{price}','{quantity}','{totalprice}','{paymentstatus}')")
            flash("Information is Stored","primary")
        
  
    
    return render_template('billing_filling.html')



@app.route('/payment_details_for_patient',methods=['POST','GET'])
def payment_details_for_patient():  

    pid=current_user.id
    query=db.engine.execute(f"SELECT * FROM `patient` WHERE `pid`='{pid}'")
    list=[post for post in query]
    patient_data=list[0]
    firstname=patient_data.firstname
    midname=patient_data.midname
    lastname=patient_data.lastname
    paymentstatus="No"
    posts=db.engine.execute(f"SELECT * FROM `billing` where `pid` ='{pid}' and `paymentstatus` ='{paymentstatus}' order by `date`")
    #SELECT * FROM `presc` where `pid`={current_user.id} and `did` =(select did from `doctors` where `dept`={dept}) 
    return render_template('payment_details.html',posts=posts,firstname=firstname,midname=midname,lastname=lastname)



@app.route('/payment_details/<int:pid>',methods=['POST','GET'])
def payment_details(pid):  

    query=db.engine.execute(f"SELECT * FROM `patient` WHERE `pid`='{pid}'")
    list=[post for post in query]
    patient_data=list[0]
    firstname=patient_data.firstname
    midname=patient_data.midname
    lastname=patient_data.lastname
    paymentstatus="No"
    posts=db.engine.execute(f"SELECT * FROM `billing` where `pid` ='{pid}' and `paymentstatus` ='{paymentstatus}' order by `date`")
    #SELECT * FROM `presc` where `pid`={current_user.id} and `did` =(select did from `doctors` where `dept`={dept}) 
    return render_template('payment_details.html',posts=posts,firstname=firstname,midname=midname,lastname=lastname)



@app.route('/Status',methods=['POST','GET'])
def Status():
    #doct=db.engine.execute("SELECT * FROM `doctors`")
    if request.method=="POST":
        pid=request.form.get('pid')
        return redirect(url_for('payment_details',pid=pid))
        
    return render_template('Status.html')


 #----------------------------------------------------------------------------------------------------------
 
 
    

#Patients slot bookings page----------------------------------------------------------------

@app.route('/patients',methods=['POST','GET'])
@login_required
def patient():
    doct=db.engine.execute("SELECT * FROM `doctors`")

    if request.method=="POST":
        email=request.form.get('email')
        firstname=request.form.get('firstname')
        midname=request.form.get('midname')
        lastname=request.form.get('lastname')
        gender=request.form.get('gender')
        date=request.form.get('date')
        slot=request.form.get('slot')
        disease=request.form.get('disease')
        dept=request.form.get('dept')
        
        post=db.engine.execute(f"SELECT `did` FROM `doctors` WHERE `dept`='{dept}'")
        list=[p.did for p in post]
        did=list[0]
        post=db.engine.execute(f"SELECT * FROM `patients` WHERE `date`='{date}' and `slot`='{slot}' and `did`='{did}'")
        count=0
        for i in post:
            count=count+1
       
        if count>1:   # U can increase count as desired
            flash("Slot if full. Please Select other slot","danger")
            return render_template('patient.html',doct=doct)
        
        
        subject="HOSPITAL MANAGEMENT SYSTEM"

  
        pid=current_user.id
        post=db.engine.execute(f"SELECT `did` FROM `doctors` WHERE `dept`='{dept}'")
        list=[p.did for p in post]
        did=list[0]
        
      
        query=db.engine.execute(f"INSERT INTO `patients` (`pid`,`date`,`did`,`firstname`,`midname`,`lastname`,`disease`,`slot`,`gender`,`email`) VALUES ('{pid}','{date}','{did}','{firstname}','{midname}','{lastname}','{disease}','{slot}','{gender}','{email}')")



        flash("Booking Confirmed","info")


    return render_template('patient.html',doct=doct)


#------------------------------------------------------------------------------




#Display bookings for Doctor and patient----------------------------------------------------------------

@app.route('/bookings')
@login_required
def bookings(): 
    em=current_user.email
    id=current_user.id
    if current_user.usertype=="Doctor":
        #query=Patients.query.all()
        dat=date.today()
        query=db.engine.execute(f"SELECT * FROM `doctors` WHERE `did`='{id}' and `email`='{em}'")
        list=[post.dept for post in query]
        dept=list[0]
        query=db.engine.execute(f"SELECT * FROM `patients` WHERE `did`='{id}' and `date`='{dat}'")
        return render_template('booking.html',query=query,dept=dept)
    else:
    
        query=db.engine.execute(f"SELECT * FROM `patients` WHERE `email`='{em}' order by `date` desc")
        # didlist=[post.did for post in query]
        # deptlist=[]
        # for did in didlist:
        #     quer=db.engine.execute(f"SELECT * FROM `doctors` WHERE `did`='{did}'")
        #     list=[post.did for post in quer]
        #     deptlist.append(list[0])    

        return render_template('booking.html',query=query)
    
    
#--------------------------------------------------------------------------------------------------------------------------------




#Nurse to check prescriptions----------------------------------------------------------------

@app.route('/prescription_details_nurse/<int:pid>',methods=['POST','GET'])
def prescription_details_nurse(pid):  

    query=db.engine.execute(f"SELECT * FROM `patient` WHERE `pid`='{pid}'")
    list=[post for post in query]
    patient_data=list[0]
    firstname=patient_data.firstname
    midname=patient_data.midname
    lastname=patient_data.lastname
    posts=db.engine.execute(f"SELECT * FROM `presc` where `pid` ='{pid}' order by `date` desc")

    #SELECT * FROM `presc` where `pid`={current_user.id} and `did` =(select did from `doctors` where `dept`={dept}) 
    return render_template('prescription_details.html',posts=posts,firstname=firstname,midname=midname,lastname=lastname)




@app.route('/nurse_prescription',methods=['POST','GET'])
def nurse_prescription():
    #doct=db.engine.execute("SELECT * FROM `doctors`")
    if request.method=="POST":
        pid=request.form.get('pid')
        return redirect(url_for('prescription_details_nurse',pid=pid))
        
    return render_template('nurse_prescription.html')


#---------------------------------------------------------------------------------------------------------------------




#Signup/login page ----------------------------------------------------------------

    
@app.route('/signup',methods=['POST','GET'])
def signup():
    if request.method == "POST":
        firstname=request.form.get('firstname')
        midname=request.form.get('midname')
        lastname=request.form.get('lastname')
        usertype="Patient"
        email=request.form.get('email')
        password=request.form.get('password')
        user=User.query.filter_by(email=email).first()
        if user:
            flash("Email Already Exist","warning")
            return render_template('/signup.html')
        encpassword=generate_password_hash(password)

        new_user=db.engine.execute(f"INSERT INTO `user` (`firstname`,`midname`,`lastname`,`email`,`usertype`,`password`) VALUES ('{firstname}','{midname}','{lastname}','{email}','{usertype}','{encpassword}')")

        
        query=db.engine.execute(f"SELECT * FROM `user` WHERE `email`='{email}'")
        list=[post.id for post in query]
        pid=list[0]

        new_patient=db.engine.execute(f"INSERT INTO `patient` (`pid`,`firstname`,`midname`,`lastname`,`email`) VALUES ('{pid}','{firstname}','{midname}','{lastname}','{email}')")

       
        flash("Signup Succes Please Login","success")
        return render_template('login.html')

          

    return render_template('signup.html')

@app.route('/login',methods=['POST','GET'])
def login():
    if request.method == "POST":
        email=request.form.get('email')
        password=request.form.get('password')
        user=User.query.filter_by(email=email).first()

        if user and check_password_hash(user.password,password):
                    login_user(user)
                    flash("Login Success","primary")
                    return redirect(url_for('index'))
        else:
            flash("invalid credentials","danger")
            return render_template('login.html')  
            
    return render_template('login.html')






@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash("Logout SuccessFul","warning")
    return redirect(url_for('login'))

#---------------------------------------------------------------------------------------------


    

@app.route('/details')
@login_required
def details():
    # posts=Trigr.query.all()
    posts=db.engine.execute("SELECT * FROM `trigr`")
    return render_template('trigers.html',posts=posts)


@app.route('/search',methods=['POST','GET'])
@login_required
def search():
    if request.method=="POST":
        query=request.form.get('search')
        dept=Doctors.query.filter_by(dept=query).first()
        name=Doctors.query.filter_by(doctorname=query).first()
        if name:

            flash("Doctor is Available","info")
        else:

            flash("Doctor is Not Available","danger")
    return render_template('index.html')






app.run(debug=True)    

