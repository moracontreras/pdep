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
    | fechaFundacion unaCiudad < 1800 = (1800 - fechaFundacion unaCiudad) * 5
    | null (atracciones unaCiudad)     = costoDeVida unaCiudad * 2
    | otherwise                        = costoDeVida unaCiudad * 3


tieneNombreRaro :: Ciudad -> Bool
tieneNombreRaro = (<5) . length . nombre

maipu :: Ciudad
maipu = UnaCiudad "Maipu" 1878 ["Fortin Kakel"] 115

azul :: Ciudad
azul = UnaCiudad "Azul" 1832 ["Teatro Español", "Parque Municipal Sarmiento", "Costanera Cacique Catriel"] 190

--Punto 2

tieneAtraccionCopada :: Ciudad -> Bool
tieneAtraccionCopada unaCiudad = any (isVowel.head).atracciones $ unaCiudad

isVowel :: Char -> Bool
isVowel character = character `elem` "aeiouAEIOU" 

esCiudadSobria :: Ciudad->Int->Bool
esCiudadSobria unaCiudad unNumero = all (>unNumero) (map length.atracciones $ unaCiudad)

--Punto 3
reevaluacion :: Ciudad -> Int -> Ciudad
reevaluacion unaCiudad cantidadDeLetras
    |esCiudadSobria unaCiudad cantidadDeLetras = modificarCostoDeVida unaCiudad (+ costoDeVida unaCiudad `div` 10)
    |otherwise                                 = modificarCostoDeVida unaCiudad (subtract 3)

modificarCostoDeVida :: Ciudad -> (Int -> Int) -> Ciudad
modificarCostoDeVida unaCiudad unaFuncion = unaCiudad { costoDeVida = unaFuncion . costoDeVida $ unaCiudad}