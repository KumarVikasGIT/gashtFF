 class User {
   late String name;
   late String email;
   late String password;
   late String user_type;


   User(this.name, this.email, this.password, this.user_type); // Setter methods
   void setName(String name1) {
   name = name1;
  }




  void setEmail(String email1) {
    email = email1;
  }

   void setPassword(String password1) {
   password = password1;
  }

   void setUserType(String userType1) {
   user_type = userType1;
  }

  // Getters (optional)
   String getName() {
    return name;
  }

   String getEmail() {
    return email;
  }

   String getPassword() {
    return password;
  }

   String getUserType() {
    return user_type;
  }


}
