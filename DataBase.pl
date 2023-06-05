%================= Restaurantes ===============%
% Formato en el que se trabaja los restaurantes :[nombre, tipoDeComida, [provincia,direccion], capacidad, [descripciones]]
%San Jose
restaurante(['McDonald''s', rapida, ['SanJose', 'Plaza del Sol'], 30, 'el restaurante es de ambiente familiar, una vestimenta casual es lo ideal']).
restaurante(['Marisqueando', mariscos,['SanJose', 'Centro de Desamparados'],20,'ofrece una amplia variedad de mariscos frescos y deliciosos, todos preparados con ingredientes de alta calidad.']).


%Cartago
restaurante(['Yokohama', japonesa, ['Cartago', 'Plaza Boulevard, Blvd. el Molino, Provincia de Cartago, Cartago'], 20, 'tiene el sushi mas conocido del pais, gran lugar para salir con amigos con deliciosa comida asiatica']).
restaurante(['Woods', italiana, ['Cartago', 'En las afueras de Cartago'], 20, 'este restaurante ofrece deliciosas pizzas artesanales, preparadas con ingredientes frescos y de alta calidad']).


%Puntarenas
restaurante(['Rostipollos', rapida, ['Puntarenas', 'Hotel Alamar'], 30, 'perfecto restaurante para ir con la familia, excelente lugar de juegos para los pequenos de la familia']).
restaurante(['BurguerKing', rapida,['Puntarenas', 'Puntarenas Down Town'],20,'es una cadena de restaurantes de comida rápida conocida por sus hamburguesas a la parrilla']).

%Heredia
restaurante(['LungFung',china,['Heredia', 'Mall Paseo de Las Flores'],20,'este restaurante ofrece aut�ntica comida china, preparada por chefs expertos en la cocina de este pa�s. En su menu encontrar�s una amplia variedad de platos tradicionales']).
restaurante(['MariscosyMas', mariscos, ['Heredia', 'Entrada principal de la UNA 100 oeste y 25 Sur'], 30, 'es un local no muy grande pero con una deliciosa cocina centrada principalmente en los frutos del mar']).

%Alajuela
restaurante(['PizzaHut', italiana, ['Alajuela', 'Centro de Alajuela'], 20, 'este restaurante ofrece deliciosas pizzas, preparadas con ingredientes frescos y de buena calidad']).
restaurante(['Matsuri', china, ['Alajuela', 'Tropicana, Provincia de Alajuela, Alajuela'],20,'es un local de comida china muy conocido en la zona, no te dejar� indiferente']).

%Guanacaste
restaurante(['Yonguang',china,['Guanacaste', 'Provincia de Guanacaste, Liberia'],20,'este restaurante te lleva en un viaje culinario a trav�s de los diferentes sabores de China.']).
restaurante(['Reina', mariscos, ['Guanacaste', 'Provincia de Guanacaste, Curime'], 30, 'un local casero en el que sirven comida proveniente del mar a un muy buen precio']).

%Limon
restaurante(['TacoBell', mexicana, ['Limon', 'Sobre carretera Braulio Carrillo, Guapiles, Limon'], 30, 'es una cadena de restaurantes de comida r�pida que sirve comida mexicana inspirada en los Estados Unidos']).
restaurante(['Rancherita',mexicana,['Limon', 'Pocora, Limon, sobre ruta 32, 100 este de Almacenes El Colono de, Limon, Pocora'],20,'su atractivo es su comida traida del mismo Mexico, con un toque nacional']).



%================= Menus ===============%
% Formato en el que se trabaja los platillos de los locales : (tipoComida, [restaurantesDisponibles], [saboresDisponibles])

menu([hamburguesa, ['McDonald''s', 'BurguerKing'], [simple, queso, vegana]]).
menu([arroz,['Yonguang','LungFung','Yokohama','Matsuri'],[pollo,cantones]]).
menu([pollo, ['BurguerKing','Rostipollos','McDonald''s'], [asado, frito]]).
menu([pescado,['Marisqueando','MariscosyMas','Reina'],[salteado, empanizado]]).
menu([camarones,['Marisqueando','MariscosyMas','Reina'],[frito, empanizado]]).
menu([taco, ['TacoBell', 'Rancherita'], [birria, pastor]]).
menu([nacho, ['TacoBell', 'Rancherita'], [res, pollo, mixto]]).
menu([sushi, ['Yokohama','Matsuri', 'LungFung','Yonguang'], [tempura, pinton]]).
menu([pizza, ['PizzaHut', 'Woods'], [pepperoni, jamon, margarita]]).
menu([lasagna, ['PizzaHut', 'Woods'], [res, pollo]]).
menu([papas, ['McDonald''s', 'Rostipollos'], [simples, arregladas]]).


%================= Bebidas ===============%
%Formato en el que se trabajan las bebidas : (tipoBebida, [restaurantesDisponibles])

bebida([cocacola, ['McDonald''s','Marisqueando','Yokohama','Woods','Rostipollos','BurguerKing','LungFung','MariscosyMas','PizzaHut','Matsuri','Yonguang','Reina','TacoBell','Rancherita']]).
bebida([pepsi, ['McDonald''s','Marisqueando','Yokohama','Woods','Rostipollos','BurguerKing','LungFung','MariscosyMas','PizzaHut','Matsuri','Yonguang','Reina','TacoBell','Rancherita']]).
bebida([sevenup, ['McDonald''s','Marisqueando','Yokohama','Woods','Rostipollos','BurguerKing','LungFung','MariscosyMas','PizzaHut','Matsuri','Yonguang','Reina','TacoBell','Rancherita']]).
bebida([te, ['Yokohama','LungFung','Matsuri','Yonguang']]).
bebida([cerveza, ['Woods','Rancherita']]).
bebida([sake, ['Yokohama','LungFung','Matsuri','Yonguang']]).
bebida([frutal, ['Marisqueando','Yokohama','Woods','Rostipollos','LungFung','MariscosyMas','Matsuri','Yonguang','Reina','Rancherita']]).


