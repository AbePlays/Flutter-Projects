# Cheat Sheet

## Add Static Files 📚

  Inside pubspec.yaml file, add file path to the following marker :
  
    flutter:
      assets:
       - images/hamilton.jpeg
       - images/lafayette.jpeg
       
  Adding an image to dart :
  
    AssetImage ham = AssetImage('images/hamilton.jpeg');
