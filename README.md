# Cheat Sheet

## Add Static Files 📚

  Inside pubspec.yaml file, add file path to the following marker :
  
    flutter:
      assets:
       - images/hamilton.jpeg
       - images/lafayette.jpeg
       
  Adding an image to dart :
  
    AssetImage ham = AssetImage('images/hamilton.jpeg');

## Working with GridView 🀆
  
  Building Grids using GridView.builder :
  
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: this.something.length, // or simply 9
      itemBuilder: (context, i) => SizedBox(
        height: 100.0,
        width: 100.0,
        child: MaterialButton(
          onPressed: () =>
            this.someFunction(i),
          child: someone,
        ),
      ),
    ),
  
