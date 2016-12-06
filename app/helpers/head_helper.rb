module HeadHelper
	def head_allow_robots?
		true
	end

	def head_title
		'SaladaApp'
	end

	def head_description
		''
	end

	def head_og_image
		asset_url 'logo.jpg'
	end

	def head_og_image_width
		'102'
	end

	def head_og_image_height
		'130'
	end
end
