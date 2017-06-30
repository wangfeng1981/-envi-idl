
pro validaverage

filters = [ '*.tif' ]
files = DIALOG_PICKFILE(/READ, FILTER = filters , /MULTIPLE_FILES)

nf = n_elements(files)
if( nf eq 0 ) then return

tdata = 1.0

envi_open_data_file, files[0] , r_fid=fid
envi_file_query, fid, dims=dims, ns=ns, nl=nl, nb=nb

sumdata = fltarr(ns,nl)
cntdata = intarr(ns,nl)


for i = 0 , nf-1 do begin
	envi_open_data_file, files[i] , r_fid=fid
	envi_file_query, fid, dims=dims, ns=ns, nl=nl, nb=nb
	tdata = envi_get_data(fid=fid, dims=dims, pos=0)
	for ix = 0 , ns-1 do begin
		for iy = 0 , nl-1 do begin
		    if( finite(tdata[ix,iy]) ) then begin
		    	sumdata[ix,iy] = sumdata[ix,iy] + tdata[ix,iy]
		    	cntdata[ix,iy] = cntdata[ix,iy] + 1
			endif
		endfor
	endfor


endfor


for ix = 0 , ns-1 do begin
	for iy = 0 , nl-1 do begin

	    	sumdata[ix,iy] = sumdata[ix,iy] / cntdata[ix,iy]

	endfor
endfor

envi_enter_data , sumdata


end