import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:barberstaff/services/authentication.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();
 

  String _email;
  String _password;
  String _city;
  String _salon;
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String email = "";
      try {

          email = await widget.auth.signIn(_email, _password);
          this._email = email;
          print('Signed in: $email');

        setState(() {
          _isLoading = false;
        });

        if (email.length > 0 && email != null && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }
  String getEmail(){
    return this._email;
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Staff Login'),
        ),
        body: Stack(
          children: <Widget>[
            
            _showForm(),
            
            _showCircularProgress(),
          ],
        ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }



  Widget _showForm() {
    return new Container(
        
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index){
              switch(index){
              case 0:
                return showLogo() ;
              case 1:
                return new Row(
                    children: <Widget>[
                      Expanded(
                        child: showCityPicker(),
                      ),
                      Expanded(
                        child: showSalonPicker(),
                        )

                    ]
                  );
              case 2:
                return showEmailInput();
              case 3:
                return showPasswordInput()  ;
              case 4:
                return showPrimaryButton()  ;
              
                  
              // return showEmailInput();
            }
            },
            // children: <Widget>[
              
            //   showOption(),
            //   // showLogo(),
            //   // showEmailInput(),
            //   // showPasswordInput(),
            //   // showPrimaryButton(),
              

            //   showErrorMessage(),
            // ],
          ),
        ));
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 100.0,
          child: Image.asset('assets/images/1.png'),
        ),
      ),
    );
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }



  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text('Login',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ));
  }
  Widget showCityPicker(){
  
  String value1  ;
  List<String> city = ["Bắc Giang", "Hà Nội"];
  
  return new  DropdownButton<String >(
      hint: Text("Select City"),
      value: value1,
      onChanged: (value){
        setState(() 
          
         => value1 = value,
         
        );
       

      },
      
      
      
      items:city
      .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })
      .toList(),
      //  onChanged: (str){ print(str);}
      
      );
  
 

}
  Widget showOption(){
    String selectedCity;
    String selectedSalon;
    return new GridView.builder(
         
        itemCount: 2,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0,childAspectRatio:1.0),
        itemBuilder:  (BuildContext context, int index){
          switch(index){
            case 0: 
                  return DropdownButton<String >(
                      hint: Text("Select City"),
                      value: selectedCity,
                      onChanged: (value){
                      selectedCity = value;
                      print(selectedCity);
                      },
      
      
                      items:<String>["Bắc Giang", "Hà Nội"]
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                      .toList(),
                   );
            case 1:
                  return DropdownButton<String >(
                      hint: Text("Select Salon"),
                      value: selectedSalon,
                      onChanged: (value){
                      selectedSalon = value;
                      print(selectedSalon);
                      },
      
      
                      items:<String>["Salon1", "Salon2"]
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                      .toList(),
                   );
          }
        }
        )
    

    ;

  }
   Widget showSalonPicker(){
  
  String value1  ;
  
  List<String> salon= ["Salon 1", "Salon 2"];
  return new  DropdownButton<String >(
      hint: Text("Select Salon"),
      value: value1,
      onChanged: (value){
        // setState(() {
          
        //   value1 = value;
        //   print(value);
        // });
        value1 = value;
        print(value1);

      },
      
      
      items:salon
      .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })
      .toList(),
      //  onChanged: (str){ print(str);}
      
      );
  
 

}
}
