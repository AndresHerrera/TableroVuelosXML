# instalo librerias, si no las tengo previamente instaladas

#install.packages("xml2")
#install.packages("htmltools")
#install.packages("pipeR")

#requiero las librerias previamente instaladas
library(xml2)
library(htmltools)
library(pipeR)

#leo el documento xml
xmldocument <- read_xml(x="vuelos.xml")

name<-xml_name(xmldocument)
aeropuertoDoc <- xml_children(xmldocument)
aeropuertoDocTags <- xml_name(aeropuertoDoc)

nombreAeropuerto <- xml_text( xml_find_all(xmldocument, ".//nombre") )
fechaVuelos <- xml_text( xml_find_all(xmldocument, ".//fecha") )

vuelos <- xml_children(aeropuertoDoc)

vuelos_codigo<-xml_attr(vuelos,"codigo")
vuelos_estado<-xml_attr(vuelos,"estado")

vuelos_diario<-  xml_find_all(vuelos, ".//diario")
vuelos_origen<-  xml_find_all(vuelos, ".//origen")
vuelos_destino<-  xml_find_all(vuelos, ".//destino")
vuelos_salida<-  xml_find_all(vuelos, ".//horasalida")
vuelos_llegada<-  xml_find_all(vuelos, ".//horallegada")

#cuento el numero de vuelos
numero_vuelos <- (length(vuelos))

#contruyo la tabla (tablero con la informacion de los vuelos)
# tedra esta estructura
# <tr>
#   <td>codigo</td>
#   <td>diario</td>
#   <td>origen</td>
#   <td>destino</td>
#   <td>horasalida</td>
#   <td>horallegada</td>
#   <td>estado</td>
#   </tr>


verificoSiDiario <- function(esDiario) {
  esDiarioS <- as.character(esDiario)
  esDiarioS[esDiarioS==""] <- "SI"
  esDiarioS[is.na(esDiarioS)] <- "NO"
  return(esDiarioS)
}

#verificoSiDiario(xml_text(vuelos_diario)[1] )
#verificoSiDiario(xml_text(vuelos_diario)[2] )
#verificoSiDiario(xml_text(vuelos_diario)[3] )

#creo una variable de texto vacia para llenarla de forma paulatina
tablero <- ""
#recorro cada vuelo y extraigo el contenido
for(i in 1:numero_vuelos) 
{ 
    tablero <-  paste(tablero,"<tr>", sep="")
    tablero <-  paste(tablero,"<td>", vuelos_codigo[i],"</td>",  sep="")
    tablero <-  paste(tablero,"<td>", verificoSiDiario(  xml_text(vuelos_diario)[i] ), "</td>",  sep="")
    tablero <-  paste(tablero,"<td>", xml_text(vuelos_origen)[i], "</td>",  sep="")
    tablero <-  paste(tablero,"<td>", xml_text(vuelos_destino)[i], "</td>",  sep="")
    tablero <-  paste(tablero,"<td>", xml_text(vuelos_salida)[i], "</td>",  sep="")
    tablero <-  paste(tablero,"<td>", xml_text(vuelos_llegada)[i], "</td>",  sep="")
    tablero <-  paste(tablero,"<td>", vuelos_estado[i], "</td>",  sep="")
    tablero <- paste(tablero,"</tr>", sep="")
}

#print(name)
#print(nombreTablero)
#print(fechaTablero)
#print(aeropuertoDoc)
#print(aeropuertoDocTags)
#print(vuelos)
#primer texto del origen del vuelo
#print(xml_text(vuelos_origen)[1])

#creo la cabecera de una tabla en HTML 

tabla_cabecera <- "<table style='width:100%' border='1px'>
  <tr>
    <th>Codigo</th>
    <th>Diario</th>
    <th>Origen</th>
    <th>Destino</th>
    <th>Hora salida</th>
    <th>Hora llegada</th>
    <th>Estado</th>
  </tr>"

#Imprimo resultado HTML en el visor de RStudio

paste("<h3>TABLERO DE VUELOS DE SALIDA DEL AEROPUERTO ", 
      nombreAeropuerto, " - ", fechaVuelos, "</h3>",
      tabla_cabecera, tablero,  "</table>" , sep ="")%>>%
  HTML %>>%
  html_print










