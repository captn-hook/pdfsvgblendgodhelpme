#this python script is meant to be launched with blender
import bpy
import os
import sys

# arg 1 should be a dir containing .svg files
try:
    svg_dir = sys.argv[5]
    files = os.listdir(svg_dir)
    print(files)
except:
    print("no svg dir specified")
    sys.exit()

# arg 2 is optional, if it exists it will be output dir
# defaults to creating a new dir adjacent to svg_dir named "output_blends"
try:
    output_dir = sys.argv[6]
    print("output dir: " + output_dir)
except:
    output_dir = os.path.join(os.path.dirname(svg_dir), "output_blends")
    print("output dir: " + output_dir)
    if not os.path.exists(output_dir):
        os.mkdir(output_dir)

#get svgs from files
svgs = []
for f in files:
    if f.endswith(".svg"):
        svgs.append(os.path.join(svg_dir, f))

#delete startup objects
print("deleting startup objects")
bpy.ops.object.select_all(action='SELECT')
bpy.ops.object.delete(use_global=False)

for svg in svgs:
    print("processing: " + svg)
    #save a blend file for each svg
    #import svg
    bpy.ops.import_curve.svg(filepath=svg)
    #save blend
    print("imported, saving blend")
    blend_name = os.path.splitext(os.path.basename(svg))[0] + ".blend"
    blend_path = os.path.join(output_dir, blend_name)
    bpy.ops.wm.save_as_mainfile(filepath=blend_path)
    #remove all objects
    print("saved, removing objects")
    bpy.ops.object.select_all(action='SELECT')
    bpy.ops.object.delete(use_global=False)
    print("removed objects")

#quit blender
bpy.ops.wm.quit_blender()