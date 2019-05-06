all: clean_all run

run: clone
	./checker.sh

clone: clean
		cp sample-images-master/image1.jpg 1.jpg
		cp sample-images-master/image2.svg 2.svg
		cp sample-images-master/image3.gif 3.gif
		cp sample-images-master/image4.png 4.png
		cp sample-images-master/image5.png 5.png

clean:
	rm -f *_$([1-5])*

clean_all: clean
	rm -f [1-5].*
