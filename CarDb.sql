--
-- PostgreSQL database dump
--

-- Dumped from database version 13.5
-- Dumped by pg_dump version 13.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: arabaindrim(real, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.arabaindrim(fiyat real, sayi integer) RETURNS real
    LANGUAGE plpgsql
    AS $$ 
BEGIN
    RETURN  fiyat*(100-sayi)/100 ;
END;
$$;


ALTER FUNCTION public.arabaindrim(fiyat real, sayi integer) OWNER TO postgres;

--
-- Name: bos_bırakmamak(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."bos_bırakmamak"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  
    IF NEW.adi IS NULL THEN
            RAISE EXCEPTION 'adi alanı boş olamaz';  
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public."bos_bırakmamak"() OWNER TO postgres;

--
-- Name: byukharf_busluk_trigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.byukharf_busluk_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

NEW.ad = LTRIM(NEW.ad);
NEW.soyad = UPPER(NEW.soyad);
RETURN NEW;
END;

$$;


ALTER FUNCTION public.byukharf_busluk_trigger() OWNER TO postgres;

--
-- Name: girelen_deger_date(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.girelen_deger_date() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
         INSERT INTO girelen_deger_date(sasiid,vakit)
         VALUES(NEW.sasiid,current_date);
 
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.girelen_deger_date() OWNER TO postgres;

--
-- Name: karakter(character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.karakter(str_tr character) RETURNS character
    LANGUAGE plpgsql
    AS $$
DECLARE
   str_x CHARACTER(100);
BEGIN
    
    str_x = str_tr;
    str_x = REPLACE(str_x,'ı','i');
    str_x = REPLACE(str_x,'ş','s');
    str_x = REPLACE(str_x,'ç','c');
    str_x = REPLACE(str_x,'ö','o');
    str_x = REPLACE(str_x,'ğ','g');
    str_x = REPLACE(str_x,'ü','u');
    return (str_x);
END;
$$;


ALTER FUNCTION public.karakter(str_tr character) OWNER TO postgres;

--
-- Name: toplam_fiyat(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toplam_fiyat() RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
BEGIN
     RETURN  (SELECT SUM("fiyat") FROM "model");
END;
$$;


ALTER FUNCTION public.toplam_fiyat() OWNER TO postgres;

--
-- Name: toplamarac_sayesi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toplamarac_sayesi() RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
BEGIN
    RETURN  (select count(*) from arac);
END;
$$;


ALTER FUNCTION public.toplamarac_sayesi() OWNER TO postgres;

--
-- Name: toplamarac_trigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toplamarac_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
BEGIN
     UPDATE toplamarac set sayi = sayi +1;
     RETURN new;
     
     
END;
$$;


ALTER FUNCTION public.toplamarac_trigger() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: arac; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.arac (
    sasiid integer NOT NULL,
    renk character varying,
    modeid integer NOT NULL,
    uretimterhi text DEFAULT ((2021 - 10) - 11),
    fabrikaid integer NOT NULL,
    turid integer NOT NULL
);


ALTER TABLE public.arac OWNER TO postgres;

--
-- Name: aracmalzeme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aracmalzeme (
    sasiid integer NOT NULL,
    malzameid integer NOT NULL,
    miktar integer
);


ALTER TABLE public.aracmalzeme OWNER TO postgres;

--
-- Name: bina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bina (
    binaid integer NOT NULL,
    binaadi character varying,
    adres character varying,
    yerlesmeid integer
);


ALTER TABLE public.bina OWNER TO postgres;

--
-- Name: calisan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.calisan (
    calisanid integer NOT NULL,
    fabrikaid integer NOT NULL
);


ALTER TABLE public.calisan OWNER TO postgres;

--
-- Name: fabrika; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fabrika (
    fabrikaid integer NOT NULL,
    adi character varying,
    ilceid integer NOT NULL,
    ilid integer NOT NULL
);


ALTER TABLE public.fabrika OWNER TO postgres;

--
-- Name: girelen_deger_date; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.girelen_deger_date (
    sasiid integer,
    vakit date
);


ALTER TABLE public.girelen_deger_date OWNER TO postgres;

--
-- Name: il; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.il (
    ilid integer NOT NULL,
    adi character varying
);


ALTER TABLE public.il OWNER TO postgres;

--
-- Name: ilce; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ilce (
    ilceid integer NOT NULL,
    adi character varying,
    "ilİd" integer
);


ALTER TABLE public.ilce OWNER TO postgres;

--
-- Name: iletisimbilgileri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.iletisimbilgileri (
    iletisimid integer NOT NULL,
    telefon integer,
    adres character varying,
    kisiid integer NOT NULL,
    ilceid integer NOT NULL
);


ALTER TABLE public.iletisimbilgileri OWNER TO postgres;

--
-- Name: kisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kisi (
    ad character varying,
    soyad character varying,
    tc integer,
    kisiid integer NOT NULL,
    kisituru character(1) NOT NULL,
    yas date
);


ALTER TABLE public.kisi OWNER TO postgres;

--
-- Name: malzame; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.malzame (
    malzameid integer NOT NULL,
    adi character varying,
    stokmiktari integer,
    tedarikciid integer NOT NULL
);


ALTER TABLE public.malzame OWNER TO postgres;

--
-- Name: model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.model (
    modelid integer NOT NULL,
    ad character varying,
    agirlik real,
    yolcusayisi integer,
    fiyat real
);


ALTER TABLE public.model OWNER TO postgres;

--
-- Name: muhemdsarac; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.muhemdsarac (
    muhendsid integer NOT NULL,
    sasiid integer NOT NULL
);


ALTER TABLE public.muhemdsarac OWNER TO postgres;

--
-- Name: muhendis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.muhendis (
    muhendisid integer NOT NULL
);


ALTER TABLE public.muhendis OWNER TO postgres;

--
-- Name: tedarikci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tedarikci (
    tedarikciid integer NOT NULL,
    adi character varying,
    vergidayresi character varying,
    vergino integer NOT NULL
);


ALTER TABLE public.tedarikci OWNER TO postgres;

--
-- Name: toplamarac; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.toplamarac (
    sayi integer
);


ALTER TABLE public.toplamarac OWNER TO postgres;

--
-- Name: tur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tur (
    turid integer NOT NULL,
    ad character varying
);


ALTER TABLE public.tur OWNER TO postgres;

--
-- Name: yerlesme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yerlesme (
    yerlesmeid integer NOT NULL,
    adi character varying,
    adres character varying,
    ilceid integer NOT NULL
);


ALTER TABLE public.yerlesme OWNER TO postgres;

--
-- Data for Name: arac; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.arac (sasiid, renk, modeid, uretimterhi, fabrikaid, turid) VALUES
	(1, 'kirmizi', 1, '2000', 2, 3),
	(2, 'mavi', 3, '2000', 1, 2),
	(3, 'siyah', 3, '2015', 1, 4),
	(4, 'sarı', 3, '2012', 2, 1);


--
-- Data for Name: aracmalzeme; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.aracmalzeme (sasiid, malzameid, miktar) VALUES
	(1, 1, 5),
	(2, 2, 8);


--
-- Data for Name: bina; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.bina (binaid, binaadi, adres, yerlesmeid) VALUES
	(1, 'loca', 'rggerg', 1),
	(2, 'fds', 'sfsfgg', 2);


--
-- Data for Name: calisan; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.calisan (calisanid, fabrikaid) VALUES
	(2, 1),
	(1, 1);


--
-- Data for Name: fabrika; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.fabrika (fabrikaid, adi, ilceid, ilid) VALUES
	(1, 'fabrika1', 1, 1),
	(2, 'fabrika2', 2, 1),
	(3, 'fabrika3', 3, 2);


--
-- Data for Name: girelen_deger_date; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.girelen_deger_date (sasiid, vakit) VALUES
	(7858, '2021-12-14'),
	(242, '2021-12-14'),
	(4, '2021-12-14'),
	(5, '2021-12-14'),
	(3, '2021-12-14'),
	(4, '2021-12-14');


--
-- Data for Name: il; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.il (ilid, adi) VALUES
	(1, 'mersin'),
	(2, 'karman'),
	(3, 'adana'),
	(4, 'antalya');


--
-- Data for Name: ilce; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ilce (ilceid, adi, "ilİd") VALUES
	(3, 'karmanilcesi', 2),
	(5, 'antalyailcesi', 4),
	(4, 'adanailcesi', 3),
	(1, 'akdeniz', 1),
	(2, 'erdmemli', 1);


--
-- Data for Name: iletisimbilgileri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.iletisimbilgileri (iletisimid, telefon, adres, kisiid, ilceid) VALUES
	(2, 53484343, '6yd6yuj', 1, 1),
	(1, 5345322, 'thydyutd', 2, 3),
	(3, 5348328, 'yhdytdy', 3, 1);


--
-- Data for Name: kisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kisi (ad, soyad, tc, kisiid, kisituru, yas) VALUES
	('ali', 'hallak', 99525725, 1, 'M', NULL),
	('muhamed', 'yılmaz', 522427578, 2, 'C', NULL),
	('yeğit', 'oglu', 878, 3, 'c', NULL),
	('can', 'yilmaz', 87857, 0, 'm', NULL),
	('muhamed', 'ALI', 4553, 4, 'm', NULL);


--
-- Data for Name: malzame; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.malzame (malzameid, adi, stokmiktari, tedarikciid) VALUES
	(1, 'nahmut', 5, 1),
	(2, NULL, 6, 2);


--
-- Data for Name: model; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.model (modelid, ad, agirlik, yolcusayisi, fiyat) VALUES
	(2, 'VW', 1500, 7, 5000),
	(3, 'Ford', 1200, 5, 4000),
	(4, 'kia', 1300, 12, 3000),
	(1, 'BMW', 1000, 5, 10);


--
-- Data for Name: muhemdsarac; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: muhendis; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.muhendis (muhendisid) VALUES
	(1);


--
-- Data for Name: tedarikci; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tedarikci (tedarikciid, adi, vergidayresi, vergino) VALUES
	(1, 'ali', 'vergi1', 2),
	(2, 'muhamed', 'vergi', 21);


--
-- Data for Name: toplamarac; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.toplamarac (sayi) VALUES
	(31);


--
-- Data for Name: tur; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tur (turid, ad) VALUES
	(1, 'sidan'),
	(2, 'sport'),
	(3, 'uzun'),
	(4, 'ticari');


--
-- Data for Name: yerlesme; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.yerlesme (yerlesmeid, adi, adres, ilceid) VALUES
	(1, 'yerlesme1', 'ferawgggggre', 1),
	(2, NULL, 'ye6ye', 2),
	(3, '', 'dwfsff', 1);


--
-- Name: aracmalzeme aracmalzeme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aracmalzeme
    ADD CONSTRAINT aracmalzeme_pkey PRIMARY KEY (malzameid, sasiid);


--
-- Name: calisan calisan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calisan
    ADD CONSTRAINT calisan_pkey PRIMARY KEY (calisanid);


--
-- Name: kisi kisi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kisi
    ADD CONSTRAINT kisi_pkey PRIMARY KEY (kisiid);


--
-- Name: model model_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model
    ADD CONSTRAINT model_pkey PRIMARY KEY (modelid);


--
-- Name: muhemdsarac muhemdsarac_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muhemdsarac
    ADD CONSTRAINT muhemdsarac_pkey PRIMARY KEY (muhendsid, sasiid);


--
-- Name: tur tur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tur
    ADD CONSTRAINT tur_pkey PRIMARY KEY (turid);


--
-- Name: arac unique_arac_sasino; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arac
    ADD CONSTRAINT unique_arac_sasino PRIMARY KEY (sasiid);


--
-- Name: bina unique_bina_binano; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bina
    ADD CONSTRAINT unique_bina_binano PRIMARY KEY (binaid);


--
-- Name: fabrika unique_fabrika_fabrikano; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fabrika
    ADD CONSTRAINT unique_fabrika_fabrikano PRIMARY KEY (fabrikaid);


--
-- Name: il unique_il_newfield; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.il
    ADD CONSTRAINT unique_il_newfield PRIMARY KEY (ilid);


--
-- Name: ilce unique_ilce_newfield; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT unique_ilce_newfield PRIMARY KEY (ilceid);


--
-- Name: iletisimbilgileri unique_iletisimbilgileri_iletisimno; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iletisimbilgileri
    ADD CONSTRAINT unique_iletisimbilgileri_iletisimno PRIMARY KEY (iletisimid);


--
-- Name: kisi unique_kisi_kisino; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kisi
    ADD CONSTRAINT unique_kisi_kisino UNIQUE (kisiid);


--
-- Name: malzame unique_malzame_malzamekodu; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.malzame
    ADD CONSTRAINT unique_malzame_malzamekodu PRIMARY KEY (malzameid);


--
-- Name: muhendis unique_table1_tasarimcino; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muhendis
    ADD CONSTRAINT unique_table1_tasarimcino PRIMARY KEY (muhendisid);


--
-- Name: tedarikci unique_tedarikci_tedarikcikodu; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tedarikci
    ADD CONSTRAINT unique_tedarikci_tedarikcikodu PRIMARY KEY (tedarikciid);


--
-- Name: yerlesme unique_yerlesme_yerleskeno; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yerlesme
    ADD CONSTRAINT unique_yerlesme_yerleskeno PRIMARY KEY (yerlesmeid);


--
-- Name: yerlesme bos_bırakımaz; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "bos_bırakımaz" BEFORE INSERT OR UPDATE ON public.yerlesme FOR EACH ROW EXECUTE FUNCTION public."bos_bırakmamak"();


--
-- Name: kisi byukharf_busluk_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER byukharf_busluk_trigger BEFORE INSERT ON public.kisi FOR EACH ROW EXECUTE FUNCTION public.byukharf_busluk_trigger();


--
-- Name: arac girelen_deger_date; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER girelen_deger_date AFTER INSERT ON public.arac FOR EACH ROW EXECUTE FUNCTION public.girelen_deger_date();


--
-- Name: arac toplamarac_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER toplamarac_trigger AFTER INSERT ON public.arac FOR EACH ROW EXECUTE FUNCTION public.toplamarac_trigger();


--
-- Name: aracmalzeme arac_aracmalzame_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aracmalzeme
    ADD CONSTRAINT arac_aracmalzame_fk FOREIGN KEY (sasiid) REFERENCES public.arac(sasiid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: muhemdsarac arac_muhendsarac_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muhemdsarac
    ADD CONSTRAINT arac_muhendsarac_fk FOREIGN KEY (sasiid) REFERENCES public.arac(sasiid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: aracmalzeme aracmalzame_malzame_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aracmalzeme
    ADD CONSTRAINT aracmalzame_malzame_fk FOREIGN KEY (malzameid) REFERENCES public.malzame(malzameid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: arac fabrika_arac; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arac
    ADD CONSTRAINT fabrika_arac FOREIGN KEY (fabrikaid) REFERENCES public.fabrika(fabrikaid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: calisan fabrika_calisan_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calisan
    ADD CONSTRAINT fabrika_calisan_fk FOREIGN KEY (fabrikaid) REFERENCES public.fabrika(fabrikaid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fabrika il_fabrika_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fabrika
    ADD CONSTRAINT il_fabrika_fk FOREIGN KEY (ilid) REFERENCES public.il(ilid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ilce il_ilce; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT il_ilce FOREIGN KEY ("ilİd") REFERENCES public.il(ilid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fabrika ilce_fabrika_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fabrika
    ADD CONSTRAINT ilce_fabrika_fk FOREIGN KEY (ilceid) REFERENCES public.ilce(ilceid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: iletisimbilgileri ilce_iletisim_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iletisimbilgileri
    ADD CONSTRAINT ilce_iletisim_fk FOREIGN KEY (ilceid) REFERENCES public.ilce(ilceid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: yerlesme ilce_yerlesme_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yerlesme
    ADD CONSTRAINT ilce_yerlesme_fk FOREIGN KEY (ilceid) REFERENCES public.ilce(ilceid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: calisan kisi_calisan_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calisan
    ADD CONSTRAINT kisi_calisan_fk FOREIGN KEY (calisanid) REFERENCES public.kisi(kisiid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: iletisimbilgileri kisi_iletisim_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iletisimbilgileri
    ADD CONSTRAINT kisi_iletisim_fk FOREIGN KEY (kisiid) REFERENCES public.kisi(kisiid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: muhendis kisi_muhends_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muhendis
    ADD CONSTRAINT kisi_muhends_fk FOREIGN KEY (muhendisid) REFERENCES public.kisi(kisiid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: arac model_arac_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arac
    ADD CONSTRAINT model_arac_fk FOREIGN KEY (modeid) REFERENCES public.model(modelid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: muhemdsarac muhends_muhendsarac_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muhemdsarac
    ADD CONSTRAINT muhends_muhendsarac_fk FOREIGN KEY (muhendsid) REFERENCES public.muhendis(muhendisid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: malzame tedarikci_malzame_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.malzame
    ADD CONSTRAINT tedarikci_malzame_fk FOREIGN KEY (tedarikciid) REFERENCES public.tedarikci(tedarikciid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: arac tur_arac_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arac
    ADD CONSTRAINT tur_arac_fk FOREIGN KEY (turid) REFERENCES public.tur(turid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bina yerlesme_bina_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bina
    ADD CONSTRAINT yerlesme_bina_fk FOREIGN KEY (yerlesmeid) REFERENCES public.yerlesme(yerlesmeid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

