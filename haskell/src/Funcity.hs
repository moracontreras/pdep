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



--punto 2


--punto 3