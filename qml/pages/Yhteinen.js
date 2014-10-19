.pragma library
var taulukko = null;
var kanta = null;

function kouluarvosana(luku) {
    var neli = Math.round(4 * luku) / 4;
    var koko = Math.floor(neli);
    var desi = neli - koko;

    if (desi == 0)
        return String(koko);
    else if (desi == 0.25)
        return koko + "+";
    else if (desi == 0.5)
        return koko + "½";
    else if (desi == 0.75)
        return koko + 1 + "–";
    else
        return "?";
}

function arvosana(pisteet, maksimipisteet, kynnysarvosana,
                  kynnysprosentti, suurin, pienin) {
    if (pisteet / maksimipisteet * 100 < kynnysprosentti)
        return kouluarvosana(pisteet / (maksimipisteet * kynnysprosentti / 100) *
                             (kynnysarvosana - pienin) + pienin);
    else
        return kouluarvosana((pisteet - (maksimipisteet * kynnysprosentti / 100)) /
                             (maksimipisteet * (100 - kynnysprosentti) / 100) *
                             (suurin - kynnysarvosana) + kynnysarvosana);
}

function muuta_luvuksi (mj) {
    mj = String(mj).trim();
    var uusi = "";
    var desimaali = false;
    for (var i = 0; i < mj.length; i++) {
        if ((mj[i] == "," || mj[i] == ".") && !desimaali) {
            uusi += ".";
            desimaali = true;
        } else if (("1234567890".indexOf(mj[i]) >= 0) ||
                   (i == 0 && (mj[i] == "+" || mj[i] == "-"))) {
            uusi += mj[i];

        } else {
            throw new Error("Ei ole luku.");
        }
    }
    return Number(uusi);
}

function desimaalipilkku(luku) {
    return String(luku).replace(".", ",")
}

function pyorista(luku, desimaalit) {
    return Number(Math.round(luku + "e" + desimaalit) + "e-" + desimaalit);
}

function laske_taulukko(suurin, pienin,
                        kynnysarvosana, kynnysprosentti,
                        maksimipisteet, pistevali) {
    try {
        var s = muuta_luvuksi(suurin);
        var p = muuta_luvuksi(pienin);
        var kas = muuta_luvuksi(kynnysarvosana);
        var kp = muuta_luvuksi(kynnysprosentti);
        var maksimi = muuta_luvuksi(maksimipisteet);
        var vali = muuta_luvuksi(pistevali);

        if (vali <= 0) vali = 1;
        maksimi = Math.abs(maksimi);

        var rivit = [];
        var pisteet, prosentti;

        for (var i = maksimi;; i -= vali) {
            pisteet = Math.max(0, i);
            prosentti = pisteet / maksimi * 100;
            rivit.push([desimaalipilkku(pyorista(pisteet, 1)),
                        arvosana(pisteet, maksimi, kas, kp, s, p),
                        desimaalipilkku(pyorista(prosentti, 1)),
                        prosentti >= kynnysprosentti]);
            if (i <= 0) break;
        }
        taulukko = rivit;
        return true;

    } catch (e) {
        return false;
    }
}
