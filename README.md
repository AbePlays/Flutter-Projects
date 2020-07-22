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
    
## Navigate across screens 🔁

  Push a screen:
  
    Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => NextPage()
        // Pass parameter inside NextPage as a Key:Value pair to send data to next screen
      )      
    );
    
  Using name routes
  
    routes: <String, WidgetBuilder> {
      '/a': (BuildContext context) => MyPage(title: 'page A'),
      '/b': (BuildContext context) => MyPage(title: 'page B'),
      '/c': (BuildContext context) => MyPage(title: 'page C'),
    },
    
    Navigator.pushNamed(context, '/b');

## Handling Api requests 📲

  Download http package from dart.
  
    var url = 'https://www.googleapis.com/books/v1/volumes?q={http}';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var itemCount = jsonResponse['totalItems'];
      print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
