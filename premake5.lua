workspace "Hydrangea"
	architecture "x64"
	startproject "Hydrangea"

	configurations
	{
		"Debug",
		"Release"
	}

	filter 'system:windows'
        	platforms { 'x86', 'x86_64' }
        	defaultplatform 'x86_64'
			defines { '_CRT_SECURE_NO_WARNINGS' }
		filter {}

outputdir = "%{cfg.buildcfg}-%{cfg.system}"

group "Hydrangea"

project "Hydrangea"
	location "hydrangea"
	kind "ConsoleApp"
	language "C++"
	staticruntime "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("build/" .. outputdir .. "/%{prj.name}")
	
	--pchheader "Util/defines.h"
	--pchsource "Util/defines.cpp"
	
	files
	{
		"%{prj.name}/include/**.h",
		"%{prj.name}/src/**.cpp",
	}
	
	filter "configurations:*"
		defines {
			"SFML_STATIC",
			"NON_MATLAB_PARSING",
			"MAX_EXT_API_CONNECTIONS=255",
			"DO_NOT_USE_SHARED_MEMORY"
		}
		includedirs {
			"%{prj.name}/include",
			"vendor/SFML/include",
			"vendor/spdlog/include",
			"vendor/V-REP"
		}
		libdirs {
			"vendor/SFML/lib"
		}
		links
		{
			"opengl32",
			"freetype",
			"winmm",
			"gdi32",
			"flac",
			"vorbisenc",
			"vorbisfile",
			"vorbis",
			"ogg",
			"ws2_32"
		}
	
	filter "system:windows"
		cppdialect "C++17"
		systemversion "latest"

	filter "configurations:Debug"
		runtime "Debug"
		defines { 'DEBUG' }
		optimize "Off"
		symbols "On"
		links
		{	
			"sfml-graphics-s-d",
			"sfml-window-s-d",
			"sfml-system-s-d",
			"sfml-audio-s-d",
			"sfml-network-s-d"
		}

	filter "configurations:Release"
		runtime "Release"
		defines { 'NDEBUG' }
		optimize "On"
		links
		{	
			"sfml-graphics-s",
			"sfml-window-s",
			"sfml-system-s",
			"sfml-audio-s",
			"sfml-network-s"
		}
		
group "Vendor"

