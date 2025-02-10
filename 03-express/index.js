const express = require('express');
const app = express();
const hbs = require('hbs');
const waxOn = require('wax-on');

// setup express to use hbs
app.set('view engine', 'hbs') // --> tells Express that we are using HBS
                              // as our view engine (template -> a method for Express to send
                             // the content of an entire file)

waxOn.on(hbs.handlebars); // enable wax-on for handlebars

// which folder to the find layout files
// layout file is a template that other templates can "copy" from
waxOn.setLayoutPath('./views/layouts');

// enable form processing
app.use(express.urlencoded({
    extended: false // disable advanced optional features that slow down express
}));

// a route is a URL mapped to a JavaScript function
// when the Express server recieves a request for the URL,
// it will the corresponding function
app.get('/', function(req,res){
    // req: what the browser/client is sending to the server
    // res: what the server is going to send back to the client
    res.render("home");

});

app.get('/about-us', function(req,res){
    // res.render is for sending the
    // back the entire content of a template file
    // --> "rendering a template"
   
    // the argument to res.render
    // is the file name of the HBS file
    // without the extension and Express
    // will assume that the file is in the /views folder
    res.render('about-us')
})

// one route to display the form (usually using GET)
app.get('/contact-us', function(req,res){
    res.render("contact-us");
})

// one route to recieve the form (usually using POST)
app.post('/contact-us', function(req,res){
    // the content of the form will be in req.body
    console.log(req.body);

    // how to manage checkboxes
    // 1. if the user never selects any checkbox, default to an empty array
    let selectedFortune = null;
    if (req.body.fortune) {
        // two  possible cases:
        // 2. user selects only one checkbox
        // 3. user selects more than one checkbox
        if (Array.isArray(req.body.fortune)) {
            // assign the array to selectedFortune
            selectedFortune = req.body.fortune;
        } else {
            selectedFortune = [ req.body.fortune ];
        }

    } else {
        selectedFortune = [];
    }
    console.log("selected fortune =", selectedFortune);
    res.send("form recieved");
})

app.get('/luckynumber', function(req,res){
    const randomNumber = Math.floor(Math.random() * 100) + 1;
    res.render('lucky', {
       'luckyNumber': randomNumber
    })
})

app.listen(3000, function(){
    console.log("Server has started")
})