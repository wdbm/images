################################################################################
#                                                                              #
# sombre-1                                                                     #
#                                                                              #
################################################################################
#                                                                              #
# LICENCE INFORMATION                                                          #
#                                                                              #
# This script applies a dark glow style to an image with a white background.   #
#                                                                              #
# copyright (C) 2015 William Breaden Madden                                    #
#                                                                              #
# This software is released under the terms of the GNU General Public License  #
# version 3 (GPLv3).                                                           #
#                                                                              #
# This program is free software: you can redistribute it and/or modify it      #
# under the terms of the GNU General Public License as published by the Free   #
# Software Foundation, either version 3 of the License, or (at your option)    #
# any later version.                                                           #
#                                                                              #
# This program is distributed in the hope that it will be useful, but WITHOUT  #
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or        #
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for     #
# more details.                                                                #
#                                                                              #
# For a copy of the GNU General Public License, see                            #
# <http://www.gnu.org/licenses/>.                                              #
#                                                                              #
################################################################################

name="sombre-1"
version="2015-07-16T2010Z"

filename="${1}"

if [ -z "${filename}" ]; then
    echo "no file specified"
    return
fi

filename_base="$(echo "${filename}" | sed -e 's/\.[a-zA-Z]*$//')"

# make negative
filename_tmp_negative=""${filename_base}"_negative.png"
echo "convert image "${filename}" to negative "${filename_tmp_negative}""
convert -negate "${filename}" "${filename_tmp_negative}"

# blur
filename_tmp_blur=""${filename_base}"_blur.png"
echo "convert image "${filename_tmp_negative}" to blur "${filename_tmp_blur}""
convert "${filename_tmp_negative}" -blur 0x80 "${filename_tmp_blur}"

# change black to transparent
filename_tmp_transparent=""${filename_base}"_transparent.png"
echo "convert image "${filename_tmp_negative}" to black transparent "${filename_tmp_transparent}""
convert "${filename_tmp_negative}" -fuzz 1% -transparent black "${filename_tmp_transparent}"

# make composite
filename_output=""${filename_base}"_sombre.png"
echo "create composite "${filename_output}""
composite -gravity center "${filename_tmp_transparent}" "${filename_tmp_blur}" "${filename_output}"

# clean
echo "clean"
rm "${filename_tmp_negative}"
rm "${filename_tmp_blur}"
rm "${filename_tmp_transparent}"
