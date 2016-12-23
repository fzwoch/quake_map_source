BSPS := $(patsubst %.map,bsp/%.bsp,$(wildcard *.map))
MAPS := $(patsubst %.bsp,%.json,$(wildcard bsp/*.bsp))
MAP_TEXTURES := $(patsubst %.tga,%.jpg,$(wildcard textures/**/*.tga))
MODELS := $(patsubst %.mdl,%.json,$(wildcard mdl/*.mdl))
MODEL_TEXTURES := $(patsubst %.tga,%.jpg,$(wildcard mdl/textures/*.tga))

all: maps map_textures models model_textures

bsps: $(BSPS)

maps: $(MAPS)

map_textures: $(MAP_TEXTURES)

models: $(MODELS)

model_textures: $(MODEL_TEXTURES)

bsp/%.bsp:%.map
	wine Txqbsp.exe $<
	wine Light.exe -soft -extra4 $@
	wine WVis.exe $@

%.jpg:%.tga
	convert $< -resize 50% $@

%.json:%.bsp
	./bsp2json $< $@

%.json:%.mdl
	./mdl2json $< $@

clean:
	find . \( -iname \*.jpg -o -iname \*.json \) -delete
