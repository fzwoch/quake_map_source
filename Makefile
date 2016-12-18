MAPS := $(patsubst %.bsp,%.json,$(wildcard bsp/*.bsp))
MAP_TEXTURES := $(patsubst %.tga,%.jpg,$(wildcard textures/*.tga))
MODELS := $(patsubst %.mdl,%.json,$(wildcard mdl/*.mdl))
MODEL_TEXTURES := $(patsubst %.tga,%.jpg,$(wildcard mdl/textures/*.tga))

all: models model_textures

maps: $(MAPS)

map_textures: $(MAP_TEXTURES)

models: $(MODELS)

model_textures: $(MODEL_TEXTURES)

%.jpg:%.tga
	convert $< -resize 50% $@

%.json:%.bsp
	@echo bsp2json $< $@

%.json:%.mdl
	./mdl2json $< $@

clean:
	rm -f bsp/*.json
	rm -f textures/*.jpg
	rm -f mdl/*.json
	rm -f mdl/textures/*.jpg
