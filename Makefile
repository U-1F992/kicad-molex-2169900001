# I/O Connectors Part - 2169900001 | Molex
# https://www.molex.com/en-us/products/part-detail/2169900001

DATASHEET_PDF = "datasheet.pdf"
DATASHEET_URL = "https://www.molex.com/en-us/products/part-detail/2169900001?display=pdf&download=true"

DATASHEET_JA_JP_PDF = "datasheet-ja-jp.pdf"
DATASHEET_JA_JP_URL = "https://www.molex.com/ja-jp/products/part-detail/2169900001?display=pdf&download=true"

DATASHEET_ZH_CN_PDF = "datasheet-zh-cn.pdf"
DATASHEET_ZH_CN_URL = "https://www.molex.com/zh-cn/products/part-detail/2169900001?display=pdf&download=true"

SALESDRAWING_PDF = "salesdrawing.pdf"
SALESDRAWING_URL = "https://www.molex.com/content/dam/molex/molex-dot-com/products/automated/en-us/salesdrawingpdf/216/216990/2169900001_sd.pdf"
SALESDRAWING_HASH = "15c100fcf5dd92f387ed788a1584eb2802c30c996594169b19c6d77ac7d59851"

PACKAGINGDESIGNDRAWING_PDF = "packagingdesigndrawing.pdf"
PACKAGINGDESIGNDRAWING_URL = "https://www.molex.com/content/dam/molex/molex-dot-com/products/automated/en-us/packagingdesigndrawing/216/216990/2169900001-PK1.pdf"

3DCADMODELS_ZIP = "3dcadmodels.zip"
3DCADMODELS_URL = "https://www.molex.com/content/dam/molex/molex-dot-com/products/automated/en-us/3dcadmodels/216/216990/2169900001_stp.zip"
3DCADMODELS_HASH = "30738a602d8f47f992446052f3ee460d48c476a0bf9bb961ba67abd61ee58ca2"

PRODUCTSPECIFICATION_PDF = "productspecification.pdf"
PRODUCTSPECIFICATION_URL = "https://www.molex.com/content/dam/molex/molex-dot-com/products/automated/en-us/productspecificationpdf/216/216990/2169900001-PS.pdf"

USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36 Edg/121.0.0.0"

.PHONY: all clean

all: clean \
	$(DATASHEET_PDF) \
	$(DATASHEET_JA_JP_PDF) \
	$(DATASHEET_ZH_CN_PDF) \
	$(SALESDRAWING_PDF) \
	$(PACKAGINGDESIGNDRAWING_PDF) \
	$(3DCADMODELS_ZIP) \
	$(PRODUCTSPECIFICATION_PDF) \
	salesdrawing-2.png \
	2169900001.pretty/2169900001.png \
	2169900001.stp

clean:
	rm -f $(DATASHEET_PDF) \
		$(DATASHEET_JA_JP_PDF) \
		$(DATASHEET_ZH_CN_PDF) \
		$(SALESDRAWING_PDF) \
		$(PACKAGINGDESIGNDRAWING_PDF) \
		$(3DCADMODELS_ZIP) \
		$(PRODUCTSPECIFICATION_PDF) \
		salesdrawing-2.png \
		2169900001.pretty/2169900001.png \
		2169900001.stp

$(DATASHEET_PDF):
	curl --location $(DATASHEET_URL) --output $@ --user-agent $(USER_AGENT)

$(DATASHEET_JA_JP_PDF):
	curl --location $(DATASHEET_JA_JP_URL) --output $@ --user-agent $(USER_AGENT)

$(DATASHEET_ZH_CN_PDF):
	curl --location $(DATASHEET_ZH_CN_URL) --output $@ --user-agent $(USER_AGENT)

$(SALESDRAWING_PDF):
	curl --location $(SALESDRAWING_URL) --output $@ --user-agent $(USER_AGENT)
	@hash=$$(shasum -a 256 $@ | awk '{print $$1}'); \
	if [ "$$hash" != "$(SALESDRAWING_HASH)" ]; then \
		echo "\033[0;33m$@ is supposed to be updated. Setup may not be completed successfully.\033[0;0m"; \
	fi

$(PACKAGINGDESIGNDRAWING_PDF):
	curl --location $(PACKAGINGDESIGNDRAWING_URL) --output $@ --user-agent $(USER_AGENT)

$(3DCADMODELS_ZIP):
	curl --location $(3DCADMODELS_URL) --output $@ --user-agent $(USER_AGENT)
	@hash=$$(shasum -a 256 $@ | awk '{print $$1}'); \
	if [ "$$hash" != "$(3DCADMODELS_HASH)" ]; then \
		echo "\033[0;33m$@ is supposed to be updated. Setup may not be completed successfully.\033[0;0m"; \
	fi

$(PRODUCTSPECIFICATION_PDF):
	curl --location $(PRODUCTSPECIFICATION_URL) --output $@ --user-agent $(USER_AGENT)

salesdrawing-2.png: $(SALESDRAWING_PDF)
	pdftoppm $< -f 2 -l 2 -png salesdrawing

2169900001.pretty/2169900001.png: salesdrawing-2.png
	convert $< -alpha set -channel A -evaluate set 50% $@

2169900001.stp: $(3DCADMODELS_ZIP)
	unzip $<