long ll_urut = 0, ll_row2, lama, ll_urut2, l_tglval, l_tgljtp, i, hari_cadangan = 0, ll_row, ll_found, sisa_waktu = 0, ll_urut_angsuran = 0, row_data = 0,gpbulan_pokok = 0,&
       ll_found_tarik = 0, jkwaktu_krdsch = 0,jkwkt_angsuran = 0,bulan_grace_pokok = 0,angsurke_bayar = 0, row = 1,ll_row_krd400his = 0,jkwkt_individu = 0,ll_row_tambahan = 0
double sldakhir, sldakhir2, bunga, angsur_bunga, ld_bulan, ld_tahun, ld_bulan2, ld_bulanjtp, ld_tahunjtp,angsuran_bayar = 0,ld_tahun2,ld_bulan_ulg
double angsuran_flat, ld_tenor, cicilan, b, sldoutstanding, sldakhir_ujung, sldakhir_ujung2, saldo_terakhir, angsur_pokok_sbl, sldakhir_sbl
decimal tot_pokok, pokok, pokoktmp, angsuran_deb = 0, total_pokok = 0, plf_debitur_awal = 0, sk_bunga_efektif, angsur_deb = 0, nilai_agunan,nilai_ckpn = 0,pokok_bayar = 0, angsur_pokok = 0,&
		   nilaicev, nltarik_baru, angsuran_baru, skbng_baru, baserate, persen_bunga, skbng_baru_asli = 0, skbng_efektif = 0, nlpokok_baru = 0, nlbunga_baru = 0,topup_plafond = 0,plafond_sbl = 0
decimal pokok_turun, nilai_real_plf, pokok_lebih,  bunga_lebih, amortisasi_pendapatan = 0, amortisasi_biaya = 0, outstanding_sbl   = 0,skbng_eir = 0, akum_nlpokok = 0
boolean flag_haricad = false, flagkrdsch = false, flag_grace_periode = false
integer nofas_hitung, x_grace_pokok = 0, row_count = 0, total_row_tglakhir_grace = 0,bulan_hit = 0, bulan_pokok_menurun,jkwaktu_menurun
string ls_hari, ls_angsur, pilih, tipejadwal, cara_bayar, rms_bunga, jnsang, dsrbng, ket, no_jamin, atsnm, addr, nodokumen, gabung, jenis_agunan,kdcab, &
		ls_search, flag_flat_efektif, flag_skbng_nol = 'N', ls_search_tglgprd, ls_search_skbunga, jenis_waktu, jns_produk, jnswkt, kota, status, ket_status, string_tglbatas,ls_bulan,ls_year,ls_tanggal,flagprsimp
datetime tglgprd, tgl_bayar, tgllunas, ldt_datetime, dt_angs, angs
date tglawal_grace, tglakhir_grace, tglakhir_grace_sch, tglawal_grace_sch, tgl_krdsch, tgljt_angsuran, tglawal_angsuran, tgltrn_menurun, jt_tempo,tglval
date tglbatas, tglputer, tgljtp, dt_angsur, tglawal, tglval_eir, tgl_angsur,tglcair,tglval_sbl

setnull(ldt_datetime)
dw_detail.reset()
dw_report.reset()
dw_head.accepttext()


//dw_detail.visible = false 
ll_urut    				= 0
bunga           		= is_rate * 0.01
kdcab              		= dw_head.getitemstring(dw_head.getrow(),'kdcab')
pilih              		= dw_head.getitemstring(dw_head.getrow(),'pilih')
lama             		= dw_head.getitemnumber(dw_head.getrow(),'lama')	
jnswkt            		= dw_head.getitemstring(dw_head.getrow(),'jnswkt')
rms_bunga    		= dw_head.getitemstring(dw_head.getrow(),'rms_bunga')
tglval             		= dw_head.getitemdate(dw_head.getrow(),'tglval')
tglval_sbl              = dw_head.getitemdate(dw_head.getrow(),'tglval_sbl')
tgl_angsuran  		= dw_head.getitemnumber(dw_head.getrow(),'tgl_angsuran')	
angsur_deb    		= dw_head.getitemdecimal(dw_head.getrow(),'cicilan')	
dsrbng           		= dw_head.getitemstring(dw_head.getrow(),'dsrbng')
tgljtp              		= dw_head.getitemdate(dw_head.getrow(),'tgljtp')
tglgprd           		= dw_head.getitemdatetime(dw_head.getrow(),'tglgprd')
tgllunas	         	= dw_head.getitemdatetime(dw_head.getrow(),'tgllunas')
flag_flat_efektif		= dw_head.getitemstring(dw_head.getrow(),'flag_flat_efektif')
is_flat					= dw_head.getitemdecimal(dw_head.getrow(),'rate')	
is_rate				= dw_head.getitemdecimal(dw_head.getrow(),'rate_efektif')	
plf_debitur			= dw_head.getitemdecimal(dw_head.getrow(),'plafond')
jns_produk			= dw_head.getitemstring(dw_head.getrow(),'jns_produk')
jenis_waktu			= dw_head.getitemstring(dw_head.getrow(),'jenis_waktu')
tgljt_angsuran 		= dw_head.getitemdate(dw_head.getrow(),'tgljt_angsuran')
jkwkt_angsuran	= dw_head.getitemnumber(dw_head.getrow(),'jkwkt_angsuran')	
plafond_sbl    		= dw_head.getitemdecimal(dw_head.getrow(),'plafond_sbl')	
skbng_eir          	= dw_head.getitemdecimal(dw_head.getrow(),'skbng_eir')	
sldakhir         		= dw_head.getitemdecimal(dw_head.Getrow(),'sldbng')	
flagprsimp            = dw_head.getitemstring(dw_head.Getrow(),'flagprsimp')
dt_angsur			= tglval
tglawal_angsuran 	= date(tglval)
sisa_waktu			= lama
jkwaktu				= lama
tglawal				= tglval
if pilih = 'A' then 
	dt_angsur =  tglval
elseif pilih = 'E' and tglval_sbl <> tglval then 
	ls_bulan = right('00'+string(month(date(tglval))),2)
	ls_year  = right('0000'+string(year(date(tglval))),4)
	ls_tanggal = ls_bulan+ '/' + right('00'+string(tgl_angsuran),2) + '/' + ls_year
	dt_angsur = date(f_tanggal1(ls_tanggal))
elseif pilih = 'E' and tglval_sbl = tglval then
	ls_bulan = right('00'+string(month(tglval)),2)
	ls_year  = right('0000'+string(year(tglval)),4)
	ls_tanggal = ls_bulan+ '/' + right('00'+string(tgl_angsuran),2) + '/' + ls_year
	dt_angsur = date(f_tanggal1(ls_tanggal))
	if tgl_angsuran <= day(date(gs_date))  then
		if flag_nlamor = true then
			select add_months(:gs_date,-1) into :tgl_nlamor from dual;
			ls_bulan = right('00'+string(month(date(tgl_nlamor))),2)
			ls_year  = right('0000'+string(year(date(tgl_nlamor))),4)
			ls_tanggal = ls_bulan+ '/' + right('00'+string(tgl_angsuran),2) + '/' + ls_year
			dt_angsur = date(f_tanggal1(ls_tanggal))
		elseif not flag_hitung_awal then 
			dt_angsur = tglval
		end if
	else
		dt_angsur = date(f_tanggal1(ls_tanggal))
	end if
	dw_head.setitem(dw_head.getrow(),'tglval',dt_angsur)
	dw_head.setitem(dw_head.getrow(),'tglval_sbl',dt_angsur)
end if
if pilih = 'A' and plafond_sbl > 0 then 
   sldakhir = plafond_sbl
end if
if step_proses = 'QUERY5'  then
	topup_plafond = w_krd_financial.tab_1.tabpage_2.dw_2.getitemdecimal(1,'topup_plafond')
elseif step_proses = 'QUERY6'   then
	topup_plafond = w_krd_financial_app.tab_1.tabpage_2.dw_2.getitemdecimal(1,'topup_plafond')
end if
if topup_plafond > 0 then // perbaikan case untuk topup plafon dimana saat buka jadwal angsuran, untuk os awalnya tidak sama dengan plafonnya
	sldakhir = topup_plafond
end if
if isnull(is_flat) then is_flat = 0 
if isnull(is_rate) then is_rate = 0 
skbng_efektif =  (2 * lama * is_flat ) / lama + 1 
dw_head.setitem(dw_head.getrow(),'skbng_efektif',skbng_efektif)
plf_debitur_awal	= plf_debitur
tglawal_grace   	= date(tglval)
tglakhir_grace   	= date(tglgprd)
select months_between(:tglakhir_grace,:tglval) into :bulan_grace_pokok  from dual ;
if date(tglakhir_grace) <= date(tglval) then 
   bulan_grace_pokok = 0
end if
//bulan_grace_pokok = daysafter(date(tglakhir_grace),date(tglval))
if isnull(bulan_grace_pokok) then bulan_grace_pokok = 0
ld_tenor		= 0
ls_hari		= string(day(date(dt_angsur)))
id_angske	= id_angske1
tgl_krdsch	= date(tglval)
tipejadwal	= dw_head.getitemstring(dw_head.getrow(),'pilih')
is_bayar  	= dw_head.getitemstring(dw_head.getrow(),'cara_bayar')
jnsang  		= dw_head.getitemstring(dw_head.getrow(),'jnsang')
hisbayar		= dw_head.getitemstring(dw_head.getrow(),'hisbayar')
ld_bulan      = month(date(dt_angsur))
if (tipejadwal = 'E' and is_bayar = '2' and dt_angsur > date(gs_date)) or (tipejadwal = 'A' and match('1',is_bayar)) then
	if hisbayar <> 'N' then
		ld_bulan = ld_bulan - 1
	end if
	if ld_bulan <= 0 then
		ld_bulan = 12
	end if
end if 
ld_tahun = year(date(dt_angsur))
if tipejadwal = 'A' and match('13',is_bayar) and ld_bulan = 12 then
	ld_tahun = ld_tahun - 1
end if
if ((day(date(tglval)) = tgl_angsuran) or (day(date(tglval)) <> tgl_angsuran and dsrbng = '1')) and is_bayar = '2' then
	flag_haricad = false
elseif day(date(tglval)) < tgl_angsuran or is_bayar = '3' then
	flag_haricad = true
// untuk in advance agar di jadwal angsurannya mulainya dari tglval bukan tglval + 1
elseif is_bayar = '1' then
	flag_haricad = true
end if
// tutup dl sementara konversi ckpn
if not flag_proses_hit_eir then 
	if rb_hari.checked  then 
		//dw_report.dataobject = 'd_query_angsuran_lap'
		dw_detail.dataobject = 'd_query_detail_angsuran' 
	else
		//dw_report.dataobject = 'd_query_angsuran_nonhari_lap'
		dw_detail.dataobject = 'd_query_detail_angsuran_nonhari'
	end if
	if rb_panjang.checked then 
		dw_report.dataobject = 'd_query_angsuran_panjang_lap'
	else
		dw_report.dataobject = 'd_query_angsuran_lap'
	end if 
	dw_report.SetTransObject(sqlca)
	dw_detail.SetTransObject(sqlca)
	dw_view_krd400his_detail.SetTransObject(sqlca)
end if
dw_view_krd400his_detail.reset()
if gs_dbengine = 'P' then // untuk DB Postgree
	select count(nofas) into :row_data from view_krd400his_detail 
	where nofas = :is_nofas and nospk = :is_nospk ;
	if row_data > 0 then 
		dw_view_krd400his_detail.retrieve(is_nofas,is_nospk)
	end if
else
	dw_view_krd400his_detail.retrieve(is_nofas,is_nospk)
end if
st_tunggu.visible = true
if rms_bunga = '9' then
	trigger event ue_jadwal_krdsch()
	goto jump
end if

if match('14',jenis_waktu) and topup_plafond = 0 then  
   if jenis_waktu = '1' and tgljt_angsuran < date(gs_date) then 
	  tgl_angsuran = day(date(tgljtp))
   else
      tgl_angsuran = day(tgljt_angsuran)
   end if
end if
if jenis_waktu = '5' then 
   angsur_deb = 0
end if
ll_urut_angsuran = 0
ld_bulanjtp = month(date(tgljtp))
ld_tahunjtp = year(date(tgljtp))
ls_angsur = right('0'+string(ld_bulanjtp),2) +'/' + right('0'+string(tgl_angsuran,'##'),2) + '/' + string(ld_tahunjtp)
if tgl_angsuran <> 0 then
	tgljtp = date(f_tanggal1(ls_angsur))
end if
  pokok_bayar      = 0
  angsurke_bayar = 0
  ls_search = "tgljt = '"+string(date(dt_angsur),'yyyy-mm')+"'"  
    ll_found = dw_view_krd400his_detail.Find(ls_search,1,dw_view_krd400his_detail.RowCount())
    if ll_found >= 1  then
		tgl_bayar = dw_view_krd400his_detail.getitemdatetime(ll_found,'tgltrn')
		angsuran_bayar = round(dw_view_krd400his_detail.getitemdecimal(ll_found,'angsuran'),0)
		pokok_bayar      = dw_view_krd400his_detail.getitemdecimal(ll_found,'nlpokok')
		angsurke_bayar = dw_view_krd400his_detail.getitemdecimal(ll_found,'angsurke')
		if angsurke_bayar <> 0 and jnsang <> '1' then pokok_bayar = 0
		if pokok_bayar > 0 and jnsang = '1'  then 
		   angsur_pokok = pokok_bayar
		end if
    else
	  tgl_bayar = datetime('00-00-0000')
	  angsuran_bayar = 0
    end if
gpbulan_pokok = 0
ld_bulan_ulg = ld_bulan
ld_tahun2 = ld_tahun
nlpokok_baru   = 0
do while dt_angsur < tgljtp AND ((sldakhir > 0 and st_kpr = '3') or st_kpr = '1')
	yield()
	if not flag_haricad then
		if match('14',jenis_waktu) then 
			if jenis_waktu = '1' then // jika harian 
				tgljt_angsuran =  date(fc_tgljatuh_tempo(tglawal_angsuran,jkwkt_angsuran,jenis_waktu,''))	 
				tgl_angsuran = day(tgljt_angsuran)
			else
				select add_months(:tglawal_angsuran,:jkwkt_angsuran) into :tgljt_angsuran from dual;
	       	end if
		   	ld_bulan = month(tgljt_angsuran)
		   	ld_tahun = year(tgljt_angsuran)
		else
			ld_bulan = ld_bulan + 1
		end if
	end if
	if ld_bulan > 12 then
		ld_bulan = 1
		ld_tahun = ld_tahun + 1
	end if
	if tgl_angsuran > day(date(tglval)) and tgl_angsuran = day(date(tglgprd)) and ll_urut = 0 and not match('14',jenis_waktu) then 
	    ld_bulan = month(date(tglval))
	    ld_tahun = year(date(tglval))
	end if
	ls_angsur = right('0'+string(ld_bulan),2) +'/' + right('0'+string(tgl_angsuran,'##'),2) + '/' + string(ld_tahun)
	IF tgl_angsuran = 0 then
		dt_angsur = tgljtp
	else
		dt_angsur = date(f_tanggal1(ls_angsur))
	end if
	if ld_tenor = 0 and ld_bulan = month(date(dt_angsur)) then 
		if jnsang = '4' or rms_bunga = '1' then // utk angsuran suka2 dan termin menurun agar ambil jadwal penarikan/angsuran berikutnya sama rownya dengan jadwal angsuran yg nantinya dibentuk
	   		tgl_krdsch = dt_angsur
		else
			select add_months(:dt_angsur,-1) into :tgl_krdsch from dual ;
		end if
	end if
	flagkrdsch = false
	angsuran_baru	= 0
	if dw_krdsch.rowcount() > 0 then 

		ls_search = "tglval_string = '"+string(date(tgl_krdsch),'yyyy-mm')+"'"   
		ll_found = dw_krdsch.Find( ls_search,1,dw_krdsch.rowcount())
		if ll_found >= 1 then
			angsuran_baru 	= dw_krdsch.getitemdecimal(ll_found,'angsuran')
			nlpokok_baru   		= dw_krdsch.getitemdecimal(ll_found,'nlpokok')
			nlbunga_baru  		= dw_krdsch.getitemdecimal(ll_found,'nlbunga')
			baserate				= dw_krdsch.getitemdecimal(ll_found,'baserate')
			skbng_baru     	 	= dw_krdsch.getitemdecimal(ll_found,'skbng')
			tglawal_grace  		= dw_krdsch.getitemdate(ll_found,'tglval')
			flag_skbng_nol		= dw_krdsch.getitemstring(ll_found,'flag_skbng_nol')
			jkwaktu_krdsch		= dw_krdsch.getitemdecimal(ll_found,'jkwaktu')
			tglakhir_grace_sch	= dw_krdsch.getitemdate(ll_found,'tglakhir_grace')
			if not isnull(tglakhir_grace_sch) and string(tglakhir_grace_sch,'dd/mm/yyyy') <> '01/01/1900' then 
			   tglakhir_grace	= date(tglakhir_grace_sch)
			end if
			skbng_baru_asli	= skbng_baru
			flagkrdsch			= true
			if isnull(angsuran_baru) then angsuran_baru = 0
			if isnull(skbng_baru_asli) then skbng_baru_asli = 0
			if isnull(jkwaktu_krdsch) then jkwaktu_krdsch = 0
		end if
		ls_search = "tglval_string = '"+string(date(dt_angsur),'yyyy-mm')+"'"   
		ll_found_tarik = dw_krdsch.Find(ls_search,1,dw_krdsch.rowcount())
		if ll_found_tarik >= 1 then
			nltarik_baru           	= dw_krdsch.getitemdecimal(ll_found_tarik,'nltarik')
			tglakhir_grace_sch		= dw_krdsch.getitemdate(ll_found_tarik,'tglakhir_grace')
			flag_skbng_nol			= dw_krdsch.getitemstring(ll_found_tarik,'flag_skbng_nol')
			ll_found_tarik = ll_found_tarik + 1
			do while ll_found_tarik > 0 and ll_found_tarik <= dw_krdsch.rowcount()
				ll_found_tarik = dw_krdsch.Find(ls_search,ll_found_tarik,dw_krdsch.rowcount())
				if ll_found_tarik <= 0  then
			         exit
				end if
				nltarik_baru			= nltarik_baru + dw_krdsch.getitemdecimal(ll_found_tarik,'nltarik')
				tglakhir_grace_sch	= dw_krdsch.getitemdate(ll_found_tarik,'tglakhir_grace')
				flag_skbng_nol		= dw_krdsch.getitemstring(ll_found_tarik,'flag_skbng_nol')
				ll_found_tarik		= ll_found_tarik + 1
			loop
			if not isnull(tglakhir_grace_sch) and string(tglakhir_grace_sch,'dd/mm/yyyy') <> '01/01/1900' then 
				tglakhir_grace 	= date(tglakhir_grace_sch)
			end if
		    if isnull(nltarik_baru) then nltarik_baru = 0
		    if flag_skbng_nol = 'Y' then 
			   is_flat = 0
			   is_rate = 0
			end if
		else
			nltarik_baru = 0
		end if
		if topup_plafond > 0 and jns_produk <> '4' then
			nltarik_baru = 0
		end if

		// agar tidak double jika di krdsch nltariknya diisi
		if date(tglval) = tglawal_grace then
			sldakhir =  sldakhir
		else
			sldakhir =  sldakhir + nltarik_baru
		end if
		if flagkrdsch  then 
			if jkwaktu_krdsch > 0  and ll_found = 1 then //and match('14',rms_bunga) then 
			   sisa_waktu = jkwaktu_krdsch 
			elseif jkwaktu_krdsch > 0  and ll_found > 1 then //and match('14',rms_bunga) then 
			   sisa_waktu = jkwaktu_krdsch - ll_urut 
			else
				if rms_bunga = '1' then
					sisa_waktu = jkwaktu 
				else
					sisa_waktu = jkwaktu -  ll_urut 
				end if 
			end if
			if jkwaktu_krdsch > lama then 
			   tgljtp = date(fc_tgljatuh_tempo(date(tglval),jkwaktu_krdsch,jnswkt,''))
			end if
			if sisa_waktu = 0 then sisa_waktu = 1
			if rms_bunga <> '1' then 
			   plf_debitur = sldakhir
			end if
			if skbng_baru_asli <= 0 and flag_skbng_nol = 'N' then 
			   if rms_bunga = '4' then 
				 skbng_baru = is_flat
			   else
			      skbng_baru =  is_rate
			   end if
			else
			    if rms_bunga = '4' then 
				  is_flat = skbng_baru
			   else
			      is_rate =  skbng_baru
			   end if
			end if
			persen_bunga = (skbng_baru * 0.01)/12
			if skbng_baru_asli > 0 then 
				 if is_bayar = '0' then
					 angsuran_baru = 0
				 elseif is_bayar = '1'  and angsuran_baru = 0 then
						if  rms_bunga = '4' then // skbunga flat
						    if flag_flat_efektif = '0' then 
							  angsuran_baru = round((plf_debitur/sisa_waktu) + (plf_debitur_awal * persen_bunga),gs_rounded)
						    else
							   angsuran_baru = round((plf_debitur/sisa_waktu) + (sldakhir * persen_bunga),gs_rounded)
						    end if
						elseif  rms_bunga = '2' then
							 angsuran_baru = round(sldakhir  * (persen_bunga /((1 - ((persen_bunga +1)^(0 - sisa_waktu)))*((persen_bunga + 1)^1))),gs_rounded)
						end if
						if angsuran_baru > 0 then 
							angsuran_baru = f_pembulatan_angsuran(jenis_pembulatan,angsuran_baru,nilai_pembulatan_bunga)
						end if
						dw_krdsch.setitem(ll_found,'angsuran',angsuran_baru)
				 elseif angsuran_baru = 0 then 	
					if  rms_bunga = '4' then // skbunga flat
					    if flag_flat_efektif = '0' then 
						  angsuran_baru = round((plf_debitur/sisa_waktu) + (plf_debitur_awal * persen_bunga),gs_rounded)
					    else
						  angsuran_baru = round((plf_debitur/sisa_waktu) + (sldakhir * persen_bunga),gs_rounded)
					    end if
					elseif  rms_bunga = '2' then
						angsuran_baru = round(sldakhir * (persen_bunga /((1 - ((persen_bunga +1)^(- sisa_waktu)))*((persen_bunga + 1)^0))),gs_rounded)
					end if
					if angsuran_baru > 0 then 
						angsuran_baru = f_pembulatan_angsuran(jenis_pembulatan,angsuran_baru,nilai_pembulatan_bunga)
					end if
					dw_krdsch.setitem(ll_found,'angsuran',angsuran_baru)
				 end if
				 if match('01',jnsang) then 
				    angsuran_baru = 0
				 end if
			 elseif skbng_baru_asli = 0 and angsuran_baru = 0 and flag_skbng_nol = 'Y' then
				 angsuran_baru = 0
			 end if
			 if step_proses = 'QUERY1'  then 
				w_master_ext.tab_1.tabpage_4.dw_4.setitem(ll_found,'angsuran',angsuran_baru)
			 elseif step_proses = 'QUERY2' then
				w_master_app.tab_1.tabpage_4.dw_4.setitem(ll_found,'angsuran',angsuran_baru)
			 elseif step_proses = 'QUERY3' then
				w_krd_kelengkapan.tab_1.tabpage_4.dw_4.setitem(ll_found,'angsuran',angsuran_baru)
			 elseif step_proses = 'QUERY4' then
				if w_krd_kelengkapan_app.tab_1.tabpage_4.dw_4.Rowcount() > 0 then 
					w_krd_kelengkapan_app.tab_1.tabpage_4.dw_4.setitem(ll_found,'angsuran',angsuran_baru)
				end if
			 elseif step_proses = 'QUERY5' then
				if w_krd_financial.tab_1.tabpage_4.dw_4.Rowcount() > 0 then 
					w_krd_financial.tab_1.tabpage_4.dw_4.setitem(ll_found,'angsuran',angsuran_baru)
				end if
			end if
		else
			angsuran_baru = 0
			baserate          = 0
			skbng_baru      = 0
			flagkrdsch        = false
		end if
	else
		angsuran_baru = 0
		baserate          = 0
		skbng_baru      = 0
		flagkrdsch        = false
	end if
	if string(tglawal_grace,'dd/mm/yyyy') <> '01/01/1900' and date(dt_angsur) >= tglawal_grace and  tglakhir_grace <> date(tglgprd) then
	   tglgprd   = datetime(tglakhir_grace)
	end if
	if date(tglgprd) <= date(dt_angsur) and date(tglgprd) > date(tglval) and ll_urut = 0 and not match('14',jenis_waktu) then 
	   hari_cadangan = daysafter(date(tglval),date(tglgprd))
	   if hari_cadangan >= 30 then

		   if  dsrbng = '1' and hari_cadangan >= 28 then
			   hari_cadangan = 30
		   end if
		  flag_grace_periode = false
	   else
		  flag_grace_periode = true
	   end if
	else
		if match('14',jenis_waktu) then 
		   if jenis_waktu = '1' then 
			 hari_cadangan = jkwkt_angsuran
		   else
			  if dsrbng = '1' then 
				 hari_cadangan = jkwkt_angsuran * 30 
			  else
				 hari_cadangan = daysafter(tglawal_angsuran,date(dt_angsur))
			  end if
		   end if
		elseif pilih = 'E' and ll_urut = 0 then
			hari_cadangan = daysafter(tglval,date(dt_angsur))
			if hari_cadangan >= 30 then
				if  dsrbng = '1' and hari_cadangan >= 28 then
					hari_cadangan = 30
				end if
			else
				hari_cadangan = 30
			end if
		else
			if dsrbng = '2' then
				 hari_cadangan = daysafter(date(tglawal),date(dt_angsur))
			else
				hari_cadangan = 30
			end if
		end if
	    if dsrbng = '1' and hari_cadangan >= 28 and not match('14',jenis_waktu) then
	       hari_cadangan = 30
	    end if
	end if
	if dsrbng = '1' and not flag_haricad and  hari_cadangan >= 28 and not match('14',jenis_waktu) then
	   if ll_urut > 0 then //day(date(tglval)) <= tgl_angsuran , perubahn ke 2  or (ll_urut = 0 and date(tglgprd) >= date(tglval)) 
	  	 hari_cadangan = 30
	   end if
	elseif pilih = 'A' and dsrbng = '1' and hari_cadangan >= 28 and not match('14',jenis_waktu) then
		hari_cadangan = 30
	end if
	if tgl_angsuran > day(date(tglval)) and tgl_angsuran = day(date(tglgprd)) and ll_urut = 0 and not match('14',jenis_waktu) then 
		if step_proses = 'EIR'  then
			if dsrbng = '2' or jenis_waktu =  '1'  then
			 	hari_cadangan = daysafter(date(tglawal),date(dt_angsur))
			else
				if jenis_waktu =  '4' then 
				   hari_cadangan = jkwkt_angsuran * 30
				else
		   			hari_cadangan = 30
     			end if
			end if
		else
			hari_cadangan = daysafter(date(tglval),date(dt_angsur))
		end if
	end if

	if tgl_angsuran = 0 then
		if dsrbng = '1' then
			select months_between(:tgljtp,:tglval) into :bulan_hit from dual;
			hari_cadangan = 30 * bulan_hit
		else //utk dasar perhitungan bunga yg hari sebenarnya
			bulan_hit = daysafter(tglval,tgljtp)
			angsur_bunga = round(fc_bunga_anuitas78(plf_debitur,is_rate/12,jkwaktu - bulan_grace_pokok,(ll_urut + 1) - x_grace_pokok),gs_rounded)
		elseif rms_bunga = '4' then
			// hari sebenarnya
			if dsrbng = '2' then
				if flag_flat_efektif = '1' then // untuk hitung bunga flat efektif
					angsur_bunga = round((((sldakhir * (is_flat  * 0.01)) / 360) * hari_cadangan),gs_rounded)
				else
					angsur_bunga = round((((plf_debitur_awal * (is_flat  * 0.01)) / 360) * hari_cadangan),gs_rounded)
				end if
			else
				if flag_flat_efektif = '1' then // untuk hitung bunga flat efektif
					angsur_bunga = round((((sldakhir * (is_flat  * 0.01)) / 360) * hari_cadangan),gs_rounded)
				else
					angsur_bunga = round((((plf_debitur_awal * (is_flat  * 0.01)) / 360) * hari_cadangan),gs_rounded)
				end if
			end if
         else
			if is_bayar = '3' then
				angsur_bunga = round((((sldakhir * (is_rate  * 0.01)) / 360) * hari_cadangan),gs_rounded)
			else
				angsur_bunga = round((((sldakhir * (is_rate  * 0.01)) / 360) * hari_cadangan),gs_rounded)
			end if
		end if
	end if
	if angsur_bunga > 0 then 
		angsur_bunga = f_pembulatan_angsuran(jenis_pembulatan,angsur_bunga,nilai_pembulatan_bunga)
	end if
	if nlbunga_baru  > 0 and  date(dt_angsur) >= tglawal_grace then 
	   angsur_bunga = nlbunga_baru
	else
		nlbunga_baru = 0
	end if
	if match('14',rms_bunga) then // jenis flat dan termin menurun 
	  if rms_bunga = '1' then//cek termin
			if nlpokok_baru > 0 then // jika krdsch nya pokoknya ada isinya
				if akum_nlpokok > 0 then
					angsur_pokok = akum_nlpokok
				else 
						angsur_pokok = nlpokok_baru
				end if 
					messagebox('pokok_bayar', string(angsur_pokok))
			else			
				if flag_flat_efektif = '1' then
					string_tglbatas = string(dt_angsur,'mm-yyyy')
					select LAST_DAY(:dt_angsur) into :tglbatas from dual;
					select sum(nlpokok) pokok_turun,max(x.tgltrn) tgltrn into :pokok_turun,:tgltrn_menurun from krd400his inner join
					(
					select nofas,nospk,max(tgltrn) tgltrn 
					from krd400his 
					where nofas = :is_nofas and nospk = :is_nospk and ststrn = '3' and tgltrn <= :tglbatas group by nofas,nospk) x
					on krd400his.nofas = x.nofas and krd400his.nospk = x.nospk 
					and krd400his.tgltrn <= x.tgltrn
					where krd400his.ststrn <> '8';			
					if isnull(pokok_turun) then
						pokok_turun = 0
					end if
					nilai_real_plf = plf_debitur - pokok_turun
					select round(months_between(:tgljtp,:tgltrn_menurun),0) into :bulan_pokok_menurun  from dual ;
					jkwaktu_menurun = bulan_pokok_menurun - bulan_grace_pokok
					if jkwaktu_menurun <= 0 then jkwaktu_menurun = 1				
					select sum(nlpokok) pokok_lebih,sum(nlbunga) bunga_lebih from krd400his inner join
					(
					select nofas,nospk,to_char(max(tgltrn),'mm-yyyy') tgltrn into :pokok_lebih,:bunga_lebih
					from krd400his 
					where nofas = :is_nofas and nospk = :is_nospk and ststrn = '3' and to_char(tgltrn,'mm-yyyy') = :string_tglbatas group by nofas,nospk) x
					on krd400his.nofas = x.nofas and krd400his.nospk = x.nospk 
					and to_char(krd400his.tgltrn,'mm-yyyy') = x.tgltrn
					where krd400his.ststrn <> '8';
					if pokok_lebih > 0 and bunga_lebih > 0 then
						angsur_pokok = pokok_lebih
						angsur_bunga = bunga_lebih
						goto lompat
					end if
					if pokok_turun > 0 then
						angsur_pokok = round(nilai_real_plf/jkwaktu_menurun,0)
									//terakhir
					messagebox('kesini 2', string(angsur_pokok))
					else
						angsur_pokok = round(plf_debitur / (sisa_waktu - bulan_grace_pokok),gs_rounded)
									//terakhir
						messagebox('kesini 3', string(angsur_pokok))
					end if
				else
					angsur_pokok = round(plf_debitur / (sisa_waktu - bulan_grace_pokok),gs_rounded)
					//terakhir
					messagebox('kesini 4', string(angsur_pokok))
				end if
			end if
	   else
				 angsur_pokok =  angsur_deb -  angsur_bunga // untuk flat
				//terakhir
			messagebox('kesini 5 ', string(angsur_pokok))
	   end if
    else
		if angsur_deb > 0 and jnsang = '2' or jnsang = '4' then // untuk jenis angsuran pokok+bunga dan angsuran suka-suka
			angsur_pokok = angsur_deb - angsur_bunga
			//terakhir
			messagebox('kesini 6 ', string(angsur_pokok))
		elseif  angsur_deb > 0 and jnsang = '1' and jenis_waktu = '5' then
			angsur_pokok = angsur_deb
					//terakhir
			messagebox('kesini 7 ', string(angsur_pokok))
		else
			angsur_pokok = 0
					//terakhir
			messagebox('kesini 8 ', string(angsur_pokok))
		end if

	end if


	lompat:
	if match('01',jnsang) then
	  if jenis_waktu = '5' then //Bulanan dan Pokok Bertahap
		if angsur_deb > 0 then 
	         angsur_pokok = angsur_deb
		elseif nlpokok_baru > 0 then
			angsur_pokok = nlpokok_baru
		end if
	  else
		if nlpokok_baru > 0 then //angsuran bunga saja jika mau dijadwal ada pokok tertera yg dari krdsch, karna di simulasi angsuran sudah bisa spt itu
		    angsur_pokok = nlpokok_baru
		else
		    angsur_pokok = 0
		    angsur_deb = angsur_bunga
		end if
	
	   end if
    end if
    pokok_bayar      = 0
    angsurke_bayar = 0
    ls_search = "tgljt = '"+string(date(dt_angsur),'yyyy-mm')+"'"  
    ll_found = dw_view_krd400his_detail.Find(ls_search,1,dw_view_krd400his_detail.RowCount())
    if ll_found >= 1  then
		tgl_bayar = dw_view_krd400his_detail.getitemdatetime(ll_found,'tgltrn')
		angsuran_bayar = round(dw_view_krd400his_detail.getitemdecimal(ll_found,'angsuran'),0)
		pokok_bayar      = dw_view_krd400his_detail.getitemdecimal(ll_found,'nlpokok')
		angsurke_bayar = dw_view_krd400his_detail.getitemdecimal(ll_found,'angsurke')
		if angsurke_bayar <> 0  and jnsang <>  '1'  then pokok_bayar = 0
		if pokok_bayar > 0 and jnsang = '1'  then 
		   angsur_pokok = pokok_bayar
		end if
			messagebox('angsur_pokok 1', string(angsur_pokok))
    else
	  tgl_bayar = datetime('00-00-0000')
	  angsuran_bayar = 0
	
    end if
	if is_bayar = '1' or is_bayar = '3' then
		if date(dt_angsur) < date(tglgprd) then
			// case udah ada tgl Grace Periode Pokok tapi tetap bayar pokok Bpr WM
			if jnsang = '2' and pokok_bayar > 0 then
				angsur_pokok = pokok_bayar
			else
				angsur_pokok = 0
			end if
		elseif 	date(tglgprd) < date(dt_angsur) and date(tglgprd) > date(tglval) and ll_urut = 0 then 
			angsur_pokok = 0
		end if
	else
		if date(dt_angsur) <= date(tglgprd) then // and date(tglgprd) >= date(dt_angsur) then //and (isnull(date()) or string(tgl_bayar,'dd-mm-yyyy') = '00-00-0000' or  string(tgl_bayar,'dd-mm-yyyy') = '01-01-1900') then
			// case udah ada tgl Grace Periode Pokok tapi tetap bayar pokok Bpr WM
			if jnsang = '2' and pokok_bayar > 0 then
				angsur_pokok = pokok_bayar
			else
				angsur_pokok = 0
			end if
		elseif 	date(tglgprd) < date(dt_angsur) and date(tglgprd) > date(tglval) and ll_urut = 0 then 
			angsur_pokok = 0
		end if
	end if
	ll_urut = dw_detail.InsertRow(0) 
	if sldakhir < 0 then sldakhir = 0
	if sldakhir > angsur_deb  and ll_urut = lama and jnsang = '2' and flag_grace_periode then 
		lama = lama + 1
		select add_months(:tgljtp,1) into :tgljtp from dual;
		flag_grace_periode = false
	end if
	if (sldakhir < angsur_deb  and angsur_deb > 0 and (ll_urut - ll_urut_angsuran) >= lama) or ((date(dt_angsur) >=date(tgljtp)) or ((ll_urut - ll_urut_angsuran) >= lama and jnsang <> '1' ))  then //rms_bunga <> '1' dihapus karna termin menurun urban 
		angsur_pokok = sldakhir
		if angsur_deb > angsur_pokok then
		   angsur_bunga = angsur_deb - angsur_pokok
		end if
		if flag_error <> 0 then 
			if (angsur_pokok + angsur_bunga) > angsur_deb then
				messagebox('Perhatian !',' Harap di perhatikan nilai angsuran apakah sudah benar ?/ atau perlu dilakukan perhitungan nilai angsuran kembali ...')
			end if
		end if
		sldakhir = 0
	else
		if sldakhir < angsur_pokok then
		   if sldakhir > 0 then 
		      angsur_pokok = sldakhir
		      angsur_bunga = round(angsur_deb - angsur_pokok,gs_rounded)
		   else
		      angsur_pokok = 0
			  angsur_bunga = 0
			  nlpokok_baru = 0
		   end if
		  		   sldakhir = 0
		else
		   sldakhir = sldakhir - angsur_pokok
		end if
	end if
	if  string(date(tgllunas),'mm-yyyy') = string(date(dt_angsur),'mm-yyyy') then
		angsur_pokok = sldakhir + angsur_pokok
		tgl_bayar = tgllunas
		sldakhir = 0
	end if
	ld_tenor  = ld_tenor + 1

	if rms_bunga = '8' and  angsur_pokok = 0 then // sum 78
	   if tgl_angsuran <> day(date(tglval)) and hari_cadangan < 30 then  // jika tgl angsuran tidak sama dengan tanggal cair
		 angsur_bunga = round(((plf_debitur * (is_rate/100))/360) * hari_cadangan,gs_rounded)
	   else	
	   	  angsur_bunga = round((plf_debitur * (is_rate/100))/12,gs_rounded)
	   end if
	end if
	if angsur_pokok = 0 then 
	   x_grace_pokok ++
	end if
	id_angske = id_angske + 1
	dw_detail.ScrollToRow(ll_urut)
	if (angsur_bunga + angsur_pokok) > 0 then 
		dw_detail.SetItem(ll_urut,'urut',ll_urut - ll_urut_angsuran)
		dw_detail.SetItem(ll_urut,'urut_string',string(ll_urut - ll_urut_angsuran))
	else
	    dw_detail.SetItem(ll_urut,'urut',0)
	    dw_detail.SetItem(ll_urut,'urut_string','0')
		ll_urut_angsuran ++
	end if
	dw_detail.SetItem(ll_urut,'tgl_angsur',dt_angsur)
	dw_detail.setitem(ll_urut,'tgl_angsur_str',string(dt_angsur,'yyyy-mm'))
	if rms_bunga = '1'  or jnsang = '1' then // jenis termin menurun dan bayar bunga saja
	   angsur_deb = round(angsur_pokok + angsur_bunga,gs_rounded)
	   if  jnsang <> '1' then
	   	  angsur_deb = f_pembulatan_angsuran(jenis_pembulatan,angsur_deb,nilai_pembulatan)
	   end if
	end if
	if isnull(no_anggota) then no_anggota = ' '
	dw_detail.SetItem(ll_urut,'rms_bunga',rms_bunga)
	dw_detail.SetItem(ll_urut,'angs_bng',angsur_bunga)
	dw_detail.SetItem(ll_urut,'angs_pokok',angsur_pokok)
	if angsur_pokok = 0 then 
		dw_detail.SetItem(ll_urut,'angs',angsur_bunga)
	elseif angsur_bunga = 0 then
		dw_detail.SetItem(ll_urut,'angs',angsur_pokok)
	else
		dw_detail.SetItem(ll_urut,'angs',angsur_deb)
	end if
	dw_detail.SetItem(ll_urut,'outstanding',round(sldakhir,2))
	dw_detail.setitem(ll_urut,'hari',hari_cadangan)
	if rms_bunga = '4' then 
	   dw_detail.setitem(ll_urut,'skbng',is_flat)
		if rb_panjang.checked then 
			   dw_report.setitem(ll_urut,'skbng',is_flat)
		end if 
	else
	   dw_detail.setitem(ll_urut,'skbng',is_rate)
		if rb_panjang.checked then 
			   dw_report.setitem(ll_urut,'skbng',is_rate)
		end if 
	end if
	dw_detail.setitem(ll_urut,'nltarik',nltarik_baru)
	if rb_panjang.checked then 
	dw_report.setitem(ll_urut,'nltarik',nltarik_baru)
	end if 
	dw_detail.SetItem(ll_urut,'tgl_bayar',tgl_bayar)
	dw_detail.SetItem(ll_urut,'angsuran',angsuran_bayar)
	if angsur_pokok = 0 then 
	   gpbulan_pokok = gpbulan_pokok + 1
	end if
	
  	ll_row2 = dw_report.insertrow(0)
	
	dw_report.setitem(ll_row2,'sldawalhari',plf_debitur)	
	if (angsur_bunga + angsur_pokok) > 0 then 
		dw_report.setitem(ll_row2,'urut',ll_row2 - ll_urut_angsuran)	
	else
		dw_report.setitem(ll_row2,'urut',0)	
	end if
	dw_report.setitem(ll_row2,'urut',ll_row2)	
	dw_report.setitem(ll_row2,'nomor',is_nofas)
	dw_report.setitem(ll_row2,'nospk',is_nospk)
	dw_report.setitem(ll_row2,'nama',trim(no_anggota+' '+trim(is_cnm)))
	dw_report.setitem(ll_row2,'npk',npk)
	dw_report.setitem(ll_row2,'pokok0',plf_debitur_awal)
	dw_report.setitem(ll_row2,'cicil',angsur_deb)
	dw_report.setitem(ll_row2,'jnsang',jnsang)
	dw_report.setitem(ll_row2,'rate',is_rate)
	dw_report.setitem(ll_row2,'flat',is_flat)
	dw_report.setitem(ll_row2,'skbng_efektif',skbng_efektif)
	dw_report.setitem(ll_row2,'tgl_angsur',dt_angsur)
	dw_report.setitem(ll_row2,'hari',hari_cadangan)
	dw_report.setitem(ll_row2,'tglberakhir',tgljtp)
	dw_report.setitem(ll_row2,'tglval',tglval)
	dw_report.setitem(ll_row2,'cara_bayar',is_bayar)
	dw_report.setitem(ll_row2,'pokok',angsur_pokok)
	dw_report.setitem(ll_urut,'bunga',angsur_bunga)
	dw_report.setitem(ll_row2,'outstanding',round(sldakhir,2))
	dw_report.setitem(ll_row2,'tgl_bayar',tgl_bayar)
	dw_report.setitem(ll_row2,'angsuran',angsuran_bayar)
	dw_report.setitem(ll_row2,'company',gs_company)
	dw_report.setitem(ll_row2,'status_bayar',dw_detail.getitemstring(dw_detail.getrow(),'status_bayar'))
	dw_report.setitem(ll_row2,'format','Jadwal Angsuran Debitur')
	dw_report.setitem(ll_row2,'rms_bunga',rms_bunga)

	tglawal = dt_angsur
	tglawal_angsuran = date(dt_angsur)
	tgl_krdsch = date(fc_tgljatuh_tempo(tgl_krdsch,1,'2',''))
	flag_haricad = false
	flagkrdsch = false
	if jenis_waktu = '5' then 
		angsur_deb = 0
	end if
	if jenis_waktu = '5' and nlpokok_baru > 0 then 
	   nlpokok_baru = 0
	end if
	st_tunggu.text = 'Retrieve sedang berlangsung : '+string(ll_row2) + ' dari : '+ string(lama) + ' angsuran Tanggal :'+string(date(dt_angsur),'dd-mmm-yyyy')+' Saldo : '+ string(sldakhir,'###,###,###,###.00')
Loop



declare mycur cursor for
	select krdjamin.no_jamin, krdjamin.atsnm, krdjamin.addr, krdjamin.nodokumen, krdjamin.nilai_agunan_yg_diperhitungkan, krdjamin.nilaicev, tbl_dokumen_jaminan.jenis_agunan, krdjamin.status 
	from krdjamin inner join tbl_dokumen_jaminan on krdjamin.kode_produk_agunan = tbl_dokumen_jaminan.kode_produk
	where nofas = :is_nofas;
	open  mycur;
	fetch mycur into :no_jamin, :atsnm, :addr, :nodokumen, :nilai_agunan, :nilaicev, :jenis_agunan, :status ;
do while sqlca.sqlcode = 0 
	if status = '5' then
		ket_status = 'Jaminan Sudah Dihapus'
	elseif status = '1' then
		ket_status = 'Jaminan Aktif'
	end if
	ket = no_jamin + ' - ' + atsnm + ' - ' + addr + ' - ' + nodokumen + ' - ' + string(nilaicev)+ ' - ' +string(nilai_agunan) + ' - ' + jenis_agunan + ' (' + ket_status + ') '
	ket = ket  + '~r~n'
	gabung = gabung + ket
	fetch mycur into :no_jamin, :atsnm, :addr, :nodokumen, :nilai_agunan, :nilaicev, :jenis_agunan, :status ;
loop
close mycur;
dw_head.setitem(dw_head.getrow(),'gpbulan_pokok',gpbulan_pokok)
if isnull(gabung) or LEN(gabung) = 0 then
	dw_detail.setitem(ll_urut,'keterangan','--')
else
	dw_detail.setitem(ll_urut,'keterangan',gabung)
end if
IF dw_detail.ROWCOUNT() > 0 THEN
   cb_print.enabled = true
   cb_excel.enabled = true
   sldakhir_sbl = sldakhir_ujung - angsur_pokok_sbl
   dw_report.SetItem(ll_row2,'bulat',sldakhir_sbl)
END IF
if dw_report.rowcount() > 0 and not isnull(tgllunas) and string(date(tgllunas),'dd/mm/yyyy') <> '01/01/1900' then 
	dw_report.setitem(dw_report.rowcount(),'tgl_lunas',tgllunas)	
	dw_report.object.tgl_lunas.visible = true
else
	dw_report.setitem(dw_report.rowcount(),'tgl_lunas',ldt_datetime)	
	dw_report.object.tgl_lunas.visible = false
end if
jump:
if flag_error <> 0 then 
	st_tunggu.visible = false
end if

dw_report.object.t_lama.text = string(jkwaktu)
if gs_company = 'KOPERASI ASTRA INTERNATIONAL' then
	dw_report.object.t_1.text = 'LAPORAN RINCIAN ANGSURAN'
	dw_report.object.t_astra.text = 'No. Anggota/Nama'
else
	dw_report.object.t_1.text = 'JADWAL ANGSURAN'
end if
if gs_company = 'PT. BPR RESTU KLEPU MAKMUR' then
	dw_report.object.kpl_cbg.text = 'Kepala '+WordCap(kpl_cbg)
	dw_report.object.kpl_cbg.visible = true
	dw_report.object.company.visible = true
	dw_report.object.t_52.visible = true
	dw_report.object.t_45.visible = true
	dw_report.object.t_49.visible = true
	dw_report.object.t_50.visible = true
	dw_report.object.t_46.visible = true
	dw_report.object.t_47.visible = true
	dw_report.object.t_51.visible = true
	dw_report.object.t_48.visible = true
end if
if gs_sandibank = '600567' then //PT BPR WELERI MAKMUR
	dw_report.object.kpl_cbg.text = kpl_cbg 
	dw_report.object.kpl_cbg.visible = true
	dw_report.object.company.visible = true
	dw_report.object.t_52.visible = true
	dw_report.object.t_45.visible = true
	dw_report.object.t_49.visible = true
	dw_report.object.t_50.visible = true
	dw_report.object.t_46.visible = true
	dw_report.object.t_47.visible = true
	dw_report.object.t_51.visible = true
	dw_report.object.t_48.visible = true
	if rms_bunga = '4' then
		dw_report.setitem(ll_row2,'flat',is_flat)
		dw_report.object.t_22.visible = false
		dw_report.object.t_8.visible = false
		dw_report.object.rate.visible = false
		dw_report.object.t_9.visible = false
	else
		dw_report.setitem(ll_row2,'rate',is_rate)
		dw_report.object.t_23.visible = false
		dw_report.object.t_10.visible = false
		dw_report.object.flat.visible = false
		dw_report.object.t_11.visible = false
	end if
end if

amortisasi_pendapatan = dw_head.getitemdecimal(dw_head.getrow(),'amor_pendapatan')
amortisasi_biaya           = dw_head.getitemdecimal(dw_head.getrow(),'amor_biaya')
if isnull(amortisasi_pendapatan) then amortisasi_pendapatan = 0
if isnull(amortisasi_biaya) then amortisasi_biaya = 0

if flag_proses_hit_eir then 
	if (not isnull(trim(mid(is_gloket,29,1))) and mid(is_gloket,29,1) = '1') or (not isnull(trim(mid(is_gloket,30,1))) and mid(is_gloket,30,1) = '1' ) then
	   dw_report.object.datawindow.readonly = 'No'

	end if
elseif  skbng_eir > 0 then 
	if flagprsimp = 'Y' then
		select count(nofas),max(tglval) into :row_data,:tglval_eir from KRDHCKPN
		where nofas = :is_nofas and nospk = :is_nospk ;
		 if row_data > 0 then 
			trigger event ue_ckpn_history(is_nofas,is_nospk,date(gs_date))
		 end if
	end if
 	dw_report.object.datawindow.readonly = 'No'
else
	dw_report.object.datawindow.readonly = 'Yes'
end if
nilai_ckpn =  dw_detail.getitemdecimal(dw_detail.rowcount(),'nilai_ckpn')
if abs(nilai_ckpn) > 0 then
   cb_hapus.enabled = true
else
   cb_hapus.enabled = false
end if
cb_additem.enabled = true
if not flag_proses_hit_eir and st_kpr <> '2' then
	trigger event ue_hitung_eir()
end if