# Cheat Sheet

## Add Static Files 📚

  Inside pubspec.yaml file, add file path to the following marker :
  
    flutter:
      assets:
       - images/hamilton.jpeg
       - images/lafayette.jpeg
       
  Adding an image to dart :
  
    AssetImage ham = AssetImage('images/hamilton.jpeg');
    
  Load image from internet :
  
    AssetImage img = Image.network('url');
    
## Woking with ListView 📃

  Building Lists using ListView.builder :
  
    ListView.builder(
      itemCount: this.something.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.anything,
          child: someone,
        );
      }
    );

## Working with GridView 🀆
  
  Building Grids using GridView.builder :
  
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: this.something.length,
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
  
## Creating a scheduled task ⏱

    Future.delayed(const Duration(seconds : 3), () {
      Do Stuff ;)
    });
    
## Working with Text Fields ⌨️

    TextFormField(
      decoration: const InputDecoration(
        hintText: 'Enter your email', // Placeholder text
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    ),
