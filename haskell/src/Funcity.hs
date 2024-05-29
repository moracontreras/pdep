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
sumarNuevaAtraccion unaAtraccion unaCiudad = agregarAtraccion unaAtraccion . modificarCostoDeVida (+(porcentaje (costoDeVida unaCiudad) 20)) $ unaCiudad

-- funcion q le haga el pocentaje al costo de vida

crisis :: Ciudad -> Ciudad
crisis unaCiudad 
  | null (atracciones unaCiudad)     = modificarCostoDeVida (subtract (porcentaje (costoDeVida unaCiudad) 10)) unaCiudad
  | otherwise                        = quitarAtraccion . modificarCostoDeVida  (subtract (porcentaje (costoDeVida unaCiudad) 10)) $ unaCiudad

remodelacion :: Int -> Ciudad -> Ciudad
remodelacion unPorcentaje unaCiudad = modificarCostoDeVida (+ (porcentaje (costoDeVida unaCiudad) unPorcentaje)) . cambiarNombre ("New " ++ ) $ unaCiudad

reevaluacion :: Ciudad -> Int -> Ciudad
reevaluacion unaCiudad cantidadDeLetras
    |esCiudadSobria unaCiudad cantidadDeLetras = modificarCostoDeVida (+ porcentaje (costoDeVida unaCiudad) 10) unaCiudad 
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
  evento :: [String]
} deriving Show

{-Para un año, queremos aplicar solo los eventos que hagan que el valor suba. 
Debe quedar como resultado la ciudad afectada con dichos eventos.-}

--punto 2
{-Dado un año y una ciudad, queremos saber si los eventos están ordenados en forma correcta, 
esto implica que el costo de vida al aplicar cada evento se va incrementando respecto al anterior evento. 
Debe haber al menos un evento para dicho año.
-}


--punto 3

discoRayado :: [String]
discoRayado = ["Azul", "Nullish"] ++ cycle ["Caleta Olivia", "Baradero"]

-- No hay un resultado posible, ya que la función debería aplicar el evento a todas las ciudades de la lista para luego evaluar su orden. Utiliza la estrategia basada en la evaluacion ansiosa, pero al ser una lista infinita, esta nunca se termina, por lo que no es posible aplicar la función.