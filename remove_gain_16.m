% ===================================================================================================
% scrip to back out the bit shifted gain of 16 out of the clinical raw image file,
%	Tushar 2019-05-01/4604/0/od/ch0/outer.raw
% and remove the end of row padding zeros
% and reduce and resize image to only red pixels
% ===================================================================================================
fname = 'Retina_0_od_ch0_outer.raw';
fid = fopen(fname);
image_data = uint16(fread(fid, 'uint16'));
fclose(fid);

% back out gain of 16 from entire file
image_data = image_data / 16;

% convert the raw image data array into a two dimensioned image array of 16-bit words
image = reshape(image_data, [3712 3300]); % 3300 rows of 3712 words (columns)

% transform image into original captured form.
image = image';	% rotate 90 degrees cw and invert horizontally

% remove the out of frame zero padding values from the end of each row.
image = image(:,1:3644); % delete non-image zero padding values

% reduce to only red color pixels
image_red = image(1:2:end,1:2:end);

% reduce to only Gr color pixels
%image_Gr = image(1:2:end,2:2:end);

% reduce to only Gb color pixels
%image_Gb = image(2:2:end,1:2:end);

% reduce to only blue color pixels
%image_blue = image(2:2:end,2:2:end);

