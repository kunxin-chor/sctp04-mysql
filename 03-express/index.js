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

app.get('/contact-us', function(req,res){
    res.render("contact-us");
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