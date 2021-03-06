// SebastiaanSchool (c) 2014 by Jeroen Leenarts
//
// SebastiaanSchool is licensed under a
// Creative Commons Attribution-NonCommercial 3.0 Unported License.
//
// You should have received a copy of the license along with this
// work.  If not, see <http://creativecommons.org/licenses/by-nc/3.0/>.

// These two lines are required to initialize Express in Cloud Code.
var express = require('express');
var parseExpressHttpsRedirect = require('parse-express-https-redirect');
var parseExpressCookieSession = require('parse-express-cookie-session');

var bulletinsController = require('cloud/controllers/bulletins.js')
var newslettersController = require('cloud/controllers/newsletters.js');
var loginController = require('cloud/controllers/login.js');

var app = express();

// Global app configuration section
app.set('views', 'cloud/views');  // Specify the folder to find templates
app.set('view engine', 'ejs');    // Set the template engine
app.use(express.bodyParser());    // Middleware for reading request body
app.use(express.cookieParser('Ns66$yQmAs{6R>9O6CFFOg40PoZeJh'));
app.use(parseExpressCookieSession({ cookie: { maxAge: 3600000 } }));
app.use(parseExpressHttpsRedirect()); // Middleware to redirect all requests to use https.
app.use(express.methodOverride());

// RESTful routes
app.get('/', newslettersController.index);
app.get('/login', loginController.index);
app.get('/logout', loginController.logout);
app.post('/login', loginController.login);

app.get('/newsletters', newslettersController.index);
app.post('/newsletters', newslettersController.create);
app.del('/newsletters/:id', newslettersController.delete);

app.get('/bulletins', bulletinsController.index);
app.post('/bulletins', bulletinsController.create);
app.del('/bulletins/:id', bulletinsController.delete);

// Attach the Express app to Cloud Code.
app.listen();
