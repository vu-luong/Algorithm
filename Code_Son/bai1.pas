type 
    loai_lao_dong = (A, B, C);

    cong_nhan = record 
        ho_va_ten: string;
        ngay_sinh: record
            ngay: 1..31;
            thang: 1..12;
            nam: integer;
        end;

        dia_chi: string;
        bac_tho: 1..7;
        luong: longint;
        xep_loai_lao_dong: loai_lao_dong;
    end;

