import xml.etree.ElementTree as ET
tree = ET.parse('vuelos.xml')
root = tree.getroot()

print('%s' % (root.tag))
print('Aeropuerto: %s' % (root.find('nombre').text))
print('Fecha: %s' % (root.find('fecha').text))
	
for vuelos in root.find('vuelos'):
	print('--------------------')
	
	print('Codigo Vuelo: %s ' % vuelos.attrib.get('codigo'))
	print('Estado Vuelo: %s ' % vuelos.attrib.get('estado')) 
	
	print('Origen: %s - Destino: %s' % (vuelos.find('origen').text , vuelos.find('destino').text))
	print('Hora Salida: %s - Hora Llegada: %s' % (vuelos.find('horasalida').text , vuelos.find('horallegada').text))
	
	if(vuelos.find('diario') != None ):
		print('Es Diario')
	else:
		print('No es Diario')

	
