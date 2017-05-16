module PagesHelper
	def pages_packs
		{
			client: [
				{
					class: 'pack',
					title: 'Visitante Free',
					subtitle: 'GRATIS',
					details: {
						'Crear y editar perfil.': 'Si',
						'Ver todos los galpones.': 'Si',
						'Ver todos los rubros de productos.': 'Si',
						'Ver todos los puestos.': 'Si',
						'Busqueda por productos.': 'Si',
						'Busqueda por palabras.': 'Si',
						'Enviar y recibir mensajes.': 'Si',
						'Ver destacado del día.': 'Si',
						'Acceder a otros destacados.': 'Si',
						'Generar reservas de productos.': 'No',
						'Promos/Ofertas de productos.': 'No'
					}
				},
				{
					class: 'pack pack-primary',
					title: 'Visitante Premium',
					subtitle: '$49,99<small>/Mes</small>',
					details: {
						'Crear y editar perfil.': 'Si',
						'Ver todos los galpones.': 'Si',
						'Ver todos los rubros de productos.': 'Si',
						'Ver todos los puestos.': 'Si',
						'Busqueda por productos.': 'Si',
						'Busqueda por palabras.': 'Si',
						'Enviar y recibir mensajes.': 'Si',
						'Ver destacado del día.': 'Si',
						'Acceder a otros destacados.': 'Si',
						'Generar reservas de productos.': 'Si',
						'Promos/Ofertas de productos.': 'Si'
					}
				}
			],
			seller: [
				{
					class: 'pack',
					title: 'Comerciante Free',
					subtitle: 'GRATIS',
					details: {
						'Crear y editar perfil.': 'Si',
						'Crear y editar datos de ubicación del puesto.': 'Si',
						'Crear y editar datos de rubro del puesto.': 'Si',
						'Publicar productos.': 'Solo 5',
						'Publicar avisos destacados.': 'No',
						'Imágenes por producto.': '1',
						'Precio por producto.': '1',
						'Publicar ofertas por producto.': 'No',
						'Ver rankings de reservas.': 'No',
						'Informe de analytics.': 'No',
						'Acciones de marketing sobre la base de visitantes.': 'No',
						'Validar tu puesto en el mapa.': 'No'
					}
				},
				{
					class: 'pack pack-primary',
					title: 'Comerciante Premium',
					subtitle: '$99,99<small>/Mes</small>',
					details: {
						'Crear y editar perfil.': 'Si',
						'Crear y editar datos de ubicación del puesto.': 'Si',
						'Crear y editar datos de rubro del puesto.': 'Si',
						'Publicar productos.': 'Ilimitado',
						'Publicar avisos destacados.': 'Si',
						'Imágenes por producto.': '5',
						'Precio por producto.': '1',
						'Publicar ofertas por producto.': 'Si',
						'Ver rankings de reservas.': 'Si',
						'Informe de analytics.': 'Si',
						'Acciones de marketing sobre la base de visitantes.': 'Si',
						'Validar tu puesto en el mapa.': 'Si'
					}
				}
			]
		}
	end
end