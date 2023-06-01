%================= Restaurantes ===============%

%Hecho que guarga el nombre del restaurante%

restaurante("McDonlald's").
restaurante("Taco Bell").
restaurante("KFC").

restaurante("Limoncello").
restaurante("Pizzeria ll Pomodoro").
restaurante("Tsunami Sushi").
restaurante("El Jardin de Lolita").

restaurante("Lena y Carbon").
restaurante("El Novillo Alegre").
restaurante("El Tipico Barrialeno").

%================= Comentario ===============%

%Dispocisiones a tener en cuenta al llegar al lugar%

comentario("McDonlald's", "El restaurante es de ambiente familiar, una vestimenta casual es lo ideal").
comentario("Taco Bell", "El restaurante aun no esta listo para cumplir con los requisitos sanitarios post-pandemia, por lo que es necesario llevar mascarilla").
comentario("KFC", "Perfecto restaurnte para ir con la familia, excelente lugar de juegos para los pequenos de la familia").

comentario("Limoncello", "Restaurante de caracter formal, perfecto para degustar un vino y conversar con tranquilidad").
comentario("Pizzeria ll Pomodoro", "Las mejores pizzas de San Jose, gran lugar para salir en pareja en un ambiente no tan formal").
comentario("Tsunami Sushi", "El sushi mas conocido del pais, gran lugar para salir con amigos con deliciosa comida asiatica").
comentario("El Jardin de Lolita", "Centrico y casual, un ambiente tranquilo para salidas, con el agregado de ser pet-friendly").

comentario("Lena y Carbon", "Lugar de alta formalidad, perfecto para almuerzos empresariales, ambiente calmado y con gran atencion").
comentario("El Novillo Alegre", "Las mejores carnes del país, al mas puro estilo de parrillada argentina, perfecto para ir con compania").
comentario("El Tipico Barrialeno", "Lugar casual y familiar, perfecto para disfrutar de cerveza nacional y de un buen partido de futbol").

%================= Menus ===============%

%Menus de los diferentes restaurantes%

menu("McDonlald's", "Comida rapida", ["Quesoburguesa", "Mcnuggets", "Papas fritas", "Pastel de manzana"]).
menu("Taco Bell", "Comida rapida", ["Taco", "Burrito", "Fiesta Fries", "Chunchywrap"]).
menu("KFC", "Comida rapida", ["Balde de pollo grande", "Balde de pollo pequeno", "Boneless", "Pure de papa"]).

menu("Limoncello", "Italiana", ["Pizza", ["Peperoni", "4 Estaciones", "Napolitana"], "Pasta", ["Bolonesa", "Carbonara", "Pomodoro"]]).
menu("Pizzeria ll Pomodoro", "Italiana", ["Pizza", ["Peperoni", "4 Estaciones", "Napolitana", "Cuatro quesos", "Margarita", "Brasilena", "Hongos"]], "Calzone").
menu("Tsunami Sushi", "Sushi", ["Rollos", ["California", "Tico", "Crab"], "Ramen", "Arroz frito", "Sopa Miso"]).
menu("El Jardin de Lolita", "Diverso", ["Hamburguesa", "Helados", "Pizza", ["Jamon y Queso", "Suprema"]]).

menu("Lena y Carbon", "Carnes", ["Churrasco", "Ribeye", "New York", "Entrana"]).
menu("El Novillo Alegre", "Carnes", ["Chorizo", "Hamburguesa", "Costilla", "Milanesa"]).
menu("El Tipico Barrialeno", "Diverso", ["Chifrijo", "Papas supremas", "Nachos mixtos", "Mondongo"]).

%================= Comida Rapida ===============%

%Diferentes restaurantes catalogados como comida rapida%

comidarapida("McDonald's", ["Quesoburguesa", "Mcnuggets", "Papas fritas", "Pastel de manzana"]).
comidarapida("Taco Bell", ["Taco", "Burrito", "Fiesta Fries", "Chunchywrap"]).
comidarapida("KFC", ["Balde de pollo grande", "Balde de pollo pequeno", "Boneless", "Pure de papa"]).

%================= Italiana ===============%

%Diferentes restaurantes catalogados como italiana%

italiana("Limoncello", ["Pizza", ["Peperoni", "4 Estaciones", "Napolitana"], "Pasta", ["Bolonesa", "Carbonara", "Pomodoro"]]).
italiana("Pizzeria ll Pomodoro", ["Pizza", ["Peperoni", "4 Estaciones", "Napolitana", "Cuatro quesos", "Margarita", "Brasilena", "Hongos"]], "Calzone").

%================= Sushi ===============%

%Diferentes restaurantes catalogados como sushi%

sushi("Tsunami Sushi", ["Rollos", ["California", "Tico", "Crab"], "Ramen", "Arroz frito", "Sopa Miso"]).

%================= Diverso ===============%

%Diferentes restaurantes catalogados como diverso%

diverso("El Jardin de Lolita", ["Hamburguesa", "Helados", "Pizza", ["Jamon y Queso", "Suprema"]]).
diverso("El Tipico Barrialeno", ["Chifrijo", "Papas supremas", "Nachos mixtos", "Mondongo"]).

%================= Carnes ===============%

%Diferentes restaurantes catalogados como Carnes%

carnes("Lena y Carbon", ["Churrasco", "Ribeye", "New York", "Entrana"]).
carnes("El Novillo Alegre", ["Chorizo", "Hamburguesa", "Costilla", "Milanesa"]).

%================= Direcciones ===============%

%Ubicacion de los diferentes lugares%

direccion("McDonlald's", "Costado Sur de Plaza Mayor, Avenida 2 ").
direccion("Taco Bell", "Costado este de la Municipalidad, Calle 0, Avenida Central").
direccion("KFC", "Costado suroeste de la Plaza Mayor de las Ruinas").
direccion("Limoncello", "Detrás del cine Magaly, La California, San José, 11801").
direccion("Pizzeria ll Pomodoro", " Av. 8, Roosevelt, San José, San Pedro").
direccion("Tsunami Sushi", "San José, San Rafael ").
direccion("El Jardin de Lolita", "50 m Este del costado Sur de la Antigua Aduana, San José, Barrrio Escalante, 10101" ).
direccion("Lena y Carbon", "San Francisco de Heredia, Costa Rica 40101").
direccion("El Tipico Barrialeno", "Barreal de Heredia, 106, Heredia").
direccion("El Novillo Alegre", "Plaza Bratsi Heredia San Fernando").

%================= Provincia ===============%

%Provincia donde se encuentran los restaurtantes%

provincia("McDonlald's", "Cartago").
provincia("Taco Bell", "Cartago").
provincia("KFC", "Cartago").
provincia("Limoncello", "San Jose").
provincia("Pizzeria ll Pomodoro", "San Jose").
provincia("Tsunami Sushi", "San Jose").
provincia("El Jardin de Lolita", "San Jose").
provincia("Lena y Carbon", "Heredia").
provincia("El Tipico Barrialeno", "Heredia").
provincia("El Novillo Alegre", "Heredia").

%================= Capacidad ===============%

%Capacidad de personas de los diferentes restaurantes%

direccion("McDonlald's", "20").
direccion("Taco Bell", "23").
direccion("KFC", "25").
direccion("Limoncello", "35").
direccion("Pizzeria ll Pomodoro", "40").
direccion("Tsunami Sushi", "36").
direccion("El Jardin de Lolita", "40").
direccion("Lena y Carbon", "28").
direccion("El Tipico Barrialeno", "30").
direccion("El Novillo Alegre", "42").