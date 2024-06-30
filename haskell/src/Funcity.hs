{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
import Text.Show.Functions ()


--Punto 1 
data Ciudad = UnaCiudad {
  nombre         :: String,
  fechaFundacion :: Int,
  atracciones    :: [String],
  costoDeVida    :: Int
} deriving Show

baradero :: Ciudad
baradero = UnaCiudad "Baradero" 1615 ["Parque del Este", "Museo Alejandro Barbich"] 150 

nullish :: Ciudad
nullish = UnaCiudad "Nullish" 1800 [] 140

caletaOlivia :: Ciudad
caletaOlivia = UnaCiudad "Caleta Olivia" 1901 ["El Gorosito", "Faro Costanera"] 120

valorDeUnaCiudad :: Ciudad -> Int
valorDeUnaCiudad unaCiudad
    | esAntigua unaCiudad          = (1800 - fechaFundacion unaCiudad) * 5 
    | noTieneAtracciones unaCiudad = (* 2) . costoDeVida $ unaCiudad 
    | otherwise                    = (* 3) . costoDeVida $ unaCiudad 

esAntigua :: Ciudad -> Bool
esAntigua unaCiudad = (<1800).fechaFundacion $ unaCiudad 

noTieneAtracciones :: Ciudad -> Bool
noTieneAtracciones unaCiudad = null (atracciones unaCiudad)

--Punto 2

tieneAtraccionCopada :: Ciudad -> Bool
tieneAtraccionCopada unaCiudad = any (isVowel.head).atracciones $ unaCiudad

isVowel :: Char -> Bool
isVowel character = character `elem` "aeiouAEIOU" 

esCiudadSobria :: Ciudad->Int->Bool
esCiudadSobria unaCiudad unNumero = all ((>unNumero).length) (atracciones unaCiudad)

tieneNombreRaro :: Ciudad -> Bool
tieneNombreRaro = (<5) . length . nombre

maipu :: Ciudad
maipu = UnaCiudad "Maipu" 1878 ["Fortin Kakel"] 115

azul :: Ciudad
azul = UnaCiudad "Azul" 1832 ["Teatro Español", "Parque Municipal Sarmiento", "Costanera Cacique Catriel"] 190


--Punto 3

sumarNuevaAtraccion :: String -> Ciudad -> Ciudad
sumarNuevaAtraccion unaAtraccion unaCiudad = agregarAtraccion unaAtraccion . modificarCostoDeVida (+(porcentajeCostoDeVida unaCiudad 20)) $ unaCiudad

porcentajeCostoDeVida :: Ciudad->Int->Int
porcentajeCostoDeVida unaCiudad unNumero = porcentaje (costoDeVida unaCiudad) unNumero

crisis :: Ciudad -> Ciudad
crisis unaCiudad 
  | noTieneAtracciones unaCiudad     = modificarCostoDeVida (subtract (porcentajeCostoDeVida unaCiudad 10)) unaCiudad
  | otherwise                        = quitarAtraccion . modificarCostoDeVida  (subtract (porcentajeCostoDeVida unaCiudad 10)) $ unaCiudad

remodelacion :: Int -> Ciudad -> Ciudad
remodelacion unPorcentaje unaCiudad = modificarCostoDeVida (+ (porcentaje (costoDeVida unaCiudad) unPorcentaje)) . cambiarNombre ("New " ++ ) $ unaCiudad

reevaluacion :: Int -> Ciudad -> Ciudad
reevaluacion cantidadDeLetras unaCiudad
    |esCiudadSobria unaCiudad cantidadDeLetras = modificarCostoDeVida (+ (porcentajeCostoDeVida unaCiudad 10)) unaCiudad 
    |otherwise                                 = modificarCostoDeVida (subtract 3) unaCiudad

modificarCostoDeVida :: (Int -> Int) -> Ciudad -> Ciudad
modificarCostoDeVida unaFuncion unaCiudad = unaCiudad { costoDeVida = unaFuncion . costoDeVida $ unaCiudad}

porcentaje :: Int -> Int -> Int
porcentaje unValor unPorcentaje = div (unValor * unPorcentaje) 100

cambiarNombre :: (String -> String) -> Ciudad-> Ciudad
cambiarNombre fn unaCiudad = unaCiudad { nombre = fn.nombre $ unaCiudad }

agregarAtraccion :: String -> Ciudad -> Ciudad
agregarAtraccion unaAtraccion unaCiudad = modificarAtracciones (unaAtraccion:) unaCiudad

quitarAtraccion:: Ciudad -> Ciudad
quitarAtraccion unaCiudad = modificarAtracciones tail unaCiudad

modificarAtracciones :: ([String] -> [String]) -> Ciudad -> Ciudad
modificarAtracciones fn unaCiudad = unaCiudad {
  atracciones = fn (atracciones unaCiudad)
}
--punto 4
{-
sumarNuevaAtraccion "Balneario Municipal Alte, Guillermo Brown".crisis.remodelacion 50.reevaluacion 14 $ azul
-}

-- ***************** SEGUNDA ENTREGA ****************

--punto 1

data Año = UnAño {
  numero :: Int,
  evento :: [Evento]
} deriving Show

type Evento = Ciudad -> Ciudad

año2022 :: Año
año2022 = UnAño 2022 [crisis, remodelacion 5, reevaluacion 7]

año2015 :: Año
año2015 = UnAño 2015 []

losAñosPasan :: Año -> Ciudad -> Ciudad
losAñosPasan (UnAño _ evento) unaCiudad = foldr (\eventos ciudad -> eventos ciudad) unaCiudad evento

algoMejor :: Ciudad->(Ciudad->Int)->Evento->Bool
algoMejor unaCiudad unCriterio unEvento = (unCriterio.unEvento $ unaCiudad) > (unCriterio unaCiudad)

eventosQueVarianElCostoDeVida :: (Evento -> Ciudad -> Bool) -> Año -> Ciudad -> [Evento]
eventosQueVarianElCostoDeVida unaFuncion (UnAño _ evento) unaCiudad = filter (\eventos -> unaFuncion eventos unaCiudad) evento

costoDeVidaQueSuba :: Año -> Ciudad -> Ciudad
costoDeVidaQueSuba unAño unaCiudad = aplicarEventos compararCostoDeVidaPositivo unAño unaCiudad

costoDeVidaQueBaje :: Año -> Ciudad -> Ciudad
costoDeVidaQueBaje unAño unaCiudad = aplicarEventos compararCostoDeVidaNegativo unAño unaCiudad

aplicarEventos :: (Evento -> Ciudad -> Bool) -> Año -> Ciudad -> Ciudad
aplicarEventos unaFuncion unAño unaCiudad = losAñosPasan (modificarAño (eventosQueVarianElCostoDeVida unaFuncion) unaCiudad unAño) unaCiudad

compararCostoDeVidaPositivo :: Evento -> Ciudad -> Bool
compararCostoDeVidaPositivo unEvento unaCiudad = costoDeVida (unEvento unaCiudad) > costoDeVida unaCiudad

compararCostoDeVidaNegativo :: Evento -> Ciudad -> Bool
compararCostoDeVidaNegativo unEvento unaCiudad = not (compararCostoDeVidaPositivo unEvento unaCiudad)

modificarAño :: (Año -> Ciudad -> [Evento]) -> Ciudad -> Año -> Año
modificarAño unaFuncion unaCiudad unAño = unAño { evento = unaFuncion unAño unaCiudad}

subirValor :: Ciudad ->Año ->Ciudad
subirValor unaCiudad (UnAño _ eventos) = foldr ($) unaCiudad. eventosQueMejoranCiudad unaCiudad $ eventos

eventosQueMejoranCiudad :: Ciudad->[Evento]->[Evento]
eventosQueMejoranCiudad unaCiudad unosEventos = filter (algoMejor unaCiudad costoDeVida) $ unosEventos

--punto 2
año2023 :: Año
año2023 = UnAño 2023 [crisis, sumarNuevaAtraccion "parque", remodelacion 10, remodelacion 20]

estaOrdenado :: [Int]->Bool
estaOrdenado [] = False
estaOrdenado (primero:[]) = True
estaOrdenado (primero:segundo:resto) = (primero < segundo) && estaOrdenado resto

eventosOrdenados :: Ciudad -> Año -> Bool
eventosOrdenados unaCiudad (UnAño _ eventos) = estaOrdenadoPorCostoDeVida.map (hacerEvento unaCiudad) $ eventos 

hacerEvento :: Ciudad ->Evento->Ciudad
hacerEvento unaCiudad unEvento = unEvento unaCiudad

ciudadesOrdenadas :: [Ciudad]->Evento->Bool
ciudadesOrdenadas unasCiudades unEvento = estaOrdenadoPorCostoDeVida.map unEvento $ unasCiudades

añosOrdenados :: Ciudad->[Año]->Bool
añosOrdenados unaCiudad unosAños = estaOrdenadoPorCostoDeVida.map (flip losAñosPasan unaCiudad) $ unosAños

estaOrdenadoPorCostoDeVida :: [Ciudad]->Bool
estaOrdenadoPorCostoDeVida unasCiudades = estaOrdenado.map costoDeVida $ unasCiudades

año2021 :: Año
año2021 = UnAño 2021 [crisis, sumarNuevaAtraccion "playa"]
--punto 3

año2024 :: Año
año2024 = UnAño {
  numero = 2024,
  evento = crisis : reevaluacion 7 : listaRemodelaciones
}

listaRemodelaciones :: [Evento]
listaRemodelaciones = map remodelacion [1..]

{- Si vamos paso a paso, recorriendo la lista de eventos del año 2024
le aplicamos crisis a la ciudad modificando su costo de vida, luego le 
aplica reevaluacion 7 y nos cambia nuevamente el costo de vida. Se 
comparan ambos valores y se espera que el primero analizado sea menor 
que el segundo, si eso ocurre continua y procede a evaluar los costos de 
vida despues de aplicar reevaluacion 7 y remodelacion 1. Lo que va a 
ocurrir es que no se cumple que el costo de vida despues de una reevaluacion 7
sea menor que el costo de vida de la ciudad despues de remodelacion 1,
por lo tanto se produce un corte y nos devuelve false. 
Esto sucede debido a que haskell utiliza lazy evaluation y no necesita
evaluar la lista completa. Con que una sola comparacion diga que la 
condicion no es verdadera va tener un corte y una respuesta. -}

discoRayado :: [Ciudad]
discoRayado = [azul, nullish] ++ cycle [caletaOlivia, baradero]

{- Al evaluar la funcion ciudadesOrdenadas utilizando la lista discoRayado, 
se va recorriendo la lista (infinita), comparando los costos de vida de las 
ciudades de la misma. Si en algun punto de la evaluacion el costo de vida no se 
encuenta ordenado de manera creciente, se detiene la evaluacion y devuelve False, 
ya que se usa lazy evaluation, sin necesidad de recorrer la lista completa para 
obtener un resultado. Al contrario, si la lista cumple con la condicion 
de estar ordenado el costo de vida de las ciudades de manera creciente, haskell
no nos daría una devolucion ya que sigue recorriendo la lista infinitamente al 
no encontrar un corte no puede devolver True. -}


laHistoriaSinFin :: [Año] 
laHistoriaSinFin = [año2021, año2022] ++ repeat año2023

{- En este caso, como el año2023 se repite infinitamente en la lista, al evaluar
la funcion añosOrdenados sobre la lista laHistoriaSinFin siempre va a devolver
False dado que la condicion que evalua la funcion es comparar si los costos de vida
son crecientes, pero al ser el mismo año esto no sucede. Es posible que haskell retorne
una respuesta a esta consulta ya que utiliza lazy evaluation y no necesita recorrer la 
lista completa para poder analizala. -}

