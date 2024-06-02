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
  | null (atracciones unaCiudad)     = modificarCostoDeVida (subtract (porcentajeCostoDeVida unaCiudad 10)) unaCiudad
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

costoDeVidaQueSuba :: Año -> Ciudad -> Ciudad
costoDeVidaQueSuba unAño unaCiudad = losAñosPasan (modificarAño eventosQueSubenElCostoDeVida unaCiudad unAño) unaCiudad

eventosQueSubenElCostoDeVida :: Año -> Ciudad -> [Evento]
eventosQueSubenElCostoDeVida (UnAño _ evento) unaCiudad = filter (\eventos -> compararCostoDeVida eventos unaCiudad) evento

costoDeVidaQueBaje :: Año -> Ciudad -> Ciudad
costoDeVidaQueBaje unAño unaCiudad = losAñosPasan (modificarAño eventosQueBajenElCostoDeVida unaCiudad unAño) unaCiudad

eventosQueBajenElCostoDeVida :: Año -> Ciudad -> [Evento]
eventosQueBajenElCostoDeVida (UnAño _ evento) unaCiudad = filter (\eventos -> not (compararCostoDeVida eventos unaCiudad)) evento

compararCostoDeVida :: Evento -> Ciudad -> Bool
compararCostoDeVida unEvento unaCiudad = costoDeVida (unEvento unaCiudad) > costoDeVida unaCiudad

modificarAño :: (Año -> Ciudad -> [Evento]) -> Ciudad -> Año -> Año
modificarAño unaFuncion unaCiudad unAño = unAño { evento = unaFuncion unAño unaCiudad}

subirValor :: Ciudad ->Año ->(Ciudad ->Int)->Ciudad
subirValor unaCiudad (UnAño _ eventos) unValor = foldr (\evento ciudad-> evento ciudad) unaCiudad (filter (algoMejor unaCiudad unValor) $ eventos)

--punto 2
año2023 :: Año
año2023 = UnAño 2023 [crisis, sumarNuevaAtraccion "parque", remodelacion 10, remodelacion 20]

eventosOrdenados :: Ciudad->Año->Bool
eventosOrdenados unaCiudad (UnAño _ []) = False
eventosOrdenados unaCiudad (UnAño _ (x:[])) = True
eventosOrdenados unaCiudad (UnAño numero (x:xs:xxs)) = (costoDeVida.x $ unaCiudad) < (costoDeVida.xs $ unaCiudad) && eventosOrdenados unaCiudad (UnAño numero (xs:xxs))

ciudadesOrdenadas :: [Ciudad]->Evento->Bool
ciudadesOrdenadas [] _ = False
ciudadesOrdenadas (x:[]) _ = True
ciudadesOrdenadas (x:xs:xxs) unEvento = (costoDeVida.unEvento $ x) < (costoDeVida.unEvento $ xs) && ciudadesOrdenadas (xs:xxs) unEvento

añosOrdenados :: Ciudad->[Año]->Bool
añosOrdenados unaCiudad [] = False
añosOrdenados unaCiudad (x:[]) = True
añosOrdenados unaCiudad (x:xs:xxs) = (costoDeVida.(losAñosPasan x) $ unaCiudad) < (costoDeVida.(losAñosPasan xs) $ unaCiudad) && añosOrdenados unaCiudad (xs:xxs) 

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

{- No es posible evaluar el año 2024 en la función eventosOrdenados. 
Para que eso suceda, debería recorrer completa la lista de números 
(ya sea utilizando lazy o eager evaluation) que toma remodelación y al
ser una lista infinita, no termina o se interrumpe por un Stack Overflow. 
En este caso, se utiliza call-by-value evaluando los parámetros (en este
caso infinitos) para después pasárselo a la función -}

discoRayado :: [String]
discoRayado = ["Azul", "Nullish"] ++ cycle ["Caleta Olivia", "Baradero"]

{- No hay un resultado posible al evaluar la lista discoRayado con la función ciudadesOrdenadas,
ya que la función debería aplicar el evento a todas las ciudades de la lista para luego
evaluar su orden. Utiliza la estrategia basada en la
evaluacion ansiosa, pero al ser una lista infinita, 
esta nunca se termina, por lo que no es posible aplicar la función.-}

laHistoriaSinFin :: [Int] 
laHistoriaSinFin = [2021, 2022] ++ repeat 2023

{- No se puede obtener un resultado al aplicar la función 
añosOrdenados a la lista laHistoriaSinFin. Se debería recorrer
la lista completa para luego poder evaluar las condiciones
de la función, utilizando eager evaluation, pero al ser una lista infinita, no es posible realizarlo.-}
