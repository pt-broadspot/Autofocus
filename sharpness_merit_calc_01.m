% ===================================================================================================
% scrip to calculate an arbitrary focus/sharpness figure of merit.
% image:	Tushar 2019-05-01/4604/0/od/ch0/outer.raw
%
% backout the added gain of 16
% remove the end of row padding zeros
% reduce and resize image to only red pixels
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

% plot the first order derivative of Gaussian filtered horizontal profile
profile_cd2 = diff(smoothdata(image_red(625,:), 'gaussian'));

% plot the element wise square of the first order derivative of Gaussian filtered horizontal profile
profile_cd2s = (diff(smoothdata(image_red(625,:), 'gaussian')).^2);

% plot the Gaussian filtered element wise square of the first order derivative of Gaussian filtered horizontal profile
profile_cd2sa = smoothdata(diff(smoothdata(image_red(625,:), 'gaussian')).^2);

s2 = sum(profile_cd2sa);

% ===================================================================================================
% ===================================================================================================

