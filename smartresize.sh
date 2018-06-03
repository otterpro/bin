# http://www.smashingmagazine.com/2015/06/efficient-image-resizing-with-imagemagick/
# resize for web using best compression
# works for both jpg and png

# usage:  smartresize <input file/dir/etc> <width> <output dir/>

# $ smartresize inputfile.png 300 outputdir/

smartresize() {
   mogrify -path $3 -filter Triangle -define filter:support=2 -thumbnail $2 -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB $1
}
