module PrimerPlateHelper
    
    CSV_DEBUG = "Plate Name,Payment Method,Plate Barcode,Sales Order #,Reference #,Well Position,Sequence Name,Sequence,Manufacturing ID,Measured Molecular Weight,Calculated Molecular Weight,OD260,nmoles,µg,Measured Concentration µM ,Final Volume µL ,Extinction Coefficient L/(mole·cm),Tm,Well Barcode
        Sheet1,OligoCard,11643249,14912748,188898252,A01,P7-finish_TSBC01-r,CAA GCA GAA GAC GGC ATA CGA GAT CGT GAT GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389902,18605.6,18605,13.88,23.66,440,100.25,236,586500,71,
        Sheet1,OligoCard,11643249,14912748,188898253,A02,P7-finish_TSBC02-r,CAA GCA GAA GAC GGC ATA CGA GAT ACA TCG GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389903,18574.1,18574,12,20.4,379,100.49,203,588100,71,
        Sheet1,OligoCard,11643249,14912748,188898254,A03,P7-finish_TSBC03-r,CAA GCA GAA GAC GGC ATA CGA GAT GCC TAA GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389904,18575,18574,17.63,30.09,559,100.3,300,585900,71,
        Sheet1,OligoCard,11643249,14912748,188898255,A04,P7-finish_TSBC04-r,CAA GCA GAA GAC GGC ATA CGA GAT TGG TCA GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389905,18605.5,18605,15.35,26.19,487,100.34,261,586100,71,
        Sheet1,OligoCard,11643249,14912748,188898256,A05,P7-finish_TSBC05-r,CAA GCA GAA GAC GGC ATA CGA GAT CAC TGT GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389906,18565.7,18565,14.31,24.58,456,100.33,245,582200,71,
        Sheet1,OligoCard,11643249,14912748,188898257,A06,P7-finish_TSBC06-r,CAA GCA GAA GAC GGC ATA CGA GAT ATT GGC GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389907,18605,18605,13.46,22.98,428,100.35,229,585500,71,
        Sheet1,OligoCard,11643249,14912748,188898258,A07,P7-finish_TSBC07-r,CAA GCA GAA GAC GGC ATA CGA GAT GAT CTG GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389908,18605.8,18605,12.96,22.15,412,100.23,221,585300,71,
        Sheet1,OligoCard,11643249,14912748,188898259,A08,P7-finish_TSBC08-r,CAA GCA GAA GAC GGC ATA CGA GAT TCA AGT GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389909,18589.8,18589,13.93,23.69,440,100.38,236,588000,70,
        Sheet1,OligoCard,11643249,14912748,188898260,A09,P7-finish_TSBC09-r,CAA GCA GAA GAC GGC ATA CGA GAT CTG ATC GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389910,18565.8,18565,12.71,21.8,405,100.46,217,583000,71,
        Sheet1,OligoCard,11643249,14912748,188898261,A10,P7-finish_TSBC10-r,CAA GCA GAA GAC GGC ATA CGA GAT AAG CTA GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389911,18598.6,18598,11.36,19.16,356,100.31,191,592700,70,
        Sheet1,OligoCard,11643249,14912748,188898262,A11,P7-finish_TSBC11-r,CAA GCA GAA GAC GGC ATA CGA GAT GTA GCC GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389912,18590.5,18590,13.2,22.56,419,100.27,225,585200,71,
        Sheet1,OligoCard,11643249,14912748,188898263,A12,P7-finish_TSBC12-r,CAA GCA GAA GAC GGC ATA CGA GAT TAC AAG GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389913,18598.9,18598,11.56,19.52,363,100.1,195,592300,70,
        Sheet1,OligoCard,11643249,14912748,188898264,B01,P7-finish_TSBC13-r,CAA GCA GAA GAC GGC ATA CGA GAT TTG ACT GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389914,18580.7,18580,13.73,23.58,438,100.34,235,582300,70,
        Sheet1,OligoCard,11643249,14912748,188898265,C01,P7-finish_TSBC14-r,CAA GCA GAA GAC GGC ATA CGA GAT GGA ACT GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389915,18614.5,18614,14.8,25.17,469,100.28,251,588200,71,
        Sheet1,OligoCard,11643249,14912748,188898266,C02,P7-finish_TSBC15-r,CAA GCA GAA GAC GGC ATA CGA GAT TGA CAT GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389916,18589.5,18589,13.97,23.77,442,100.3,237,587600,70,
        Sheet1,OligoCard,11643249,14912748,188898267,C03,P7-finish_TSBC16-r,CAA GCA GAA GAC GGC ATA CGA GAT GGA CGG GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389917,18655.7,18655,16.14,27.4,511,100,274,588900,72,
        Sheet1,OligoCard,11643249,14912748,188898268,C04,P7-finish_TSBC17-r,CAA GCA GAA GAC GGC ATA CGA GAT CTC TAC GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389918,18526.3,18525,11.96,20.62,382,100.1,206,579900,70,
        Sheet1,OligoCard,11643249,14912748,188898269,C05,P7-finish_TSBC18-r,CAA GCA GAA GAC GGC ATA CGA GAT GCG GAC GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389919,18615.4,18615,12.84,21.93,408,100.14,219,585400,72,
        Sheet1,OligoCard,11643249,14912748,188898270,C06,P7-finish_TSBC19-r,CAA GCA GAA GAC GGC ATA CGA GAT TTT CAC GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389920,18540.4,18540,10.9,18.79,348,100.48,187,580200,70,
        Sheet1,OligoCard,11643249,14912748,188898271,C07,P7-finish_TSBC20-r,CAA GCA GAA GAC GGC ATA CGA GAT GGC CAC GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389921,18575.9,18575,14.59,25.06,465,100.24,250,582100,72,
        Sheet1,OligoCard,11643249,14912748,188898272,C08,P7-finish_TSBC21-r,CAA GCA GAA GAC GGC ATA CGA GAT CGA AAC GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389922,18584.1,18583,14.28,24.18,449,100.33,241,590400,71,
        Sheet1,OligoCard,11643249,14912748,188898273,C09,P7-finish_TSBC22-r,CAA GCA GAA GAC GGC ATA CGA GAT CGT ACG GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389923,18591.1,18590,16.52,28.19,524,100.32,281,586000,71,
        Sheet1,OligoCard,11643249,14912748,188898274,C10,P7-finish_TSBC23-r,CAA GCA GAA GAC GGC ATA CGA GAT CCA CTC GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389924,18510.5,18510,12.56,21.72,402,100.09,217,578400,71,
        Sheet1,OligoCard,11643249,14912748,188898275,C11,P7-finish_TSBC24-r,CAA GCA GAA GAC GGC ATA CGA GAT GCT ACC GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389925,18551,18550,11.92,20.53,381,100.15,205,580700,71,
        Sheet1,OligoCard,11643249,14912748,188898276,C12,P7-finish_TSBC25-r,CAA GCA GAA GAC GGC ATA CGA GAT ATC AGT GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389926,18589.6,18589,14.15,23.98,446,100.33,239,590000,70,
        Sheet1,OligoCard,11643249,14912748,188898277,D01,P7-finish_TSBC26-r,CAA GCA GAA GAC GGC ATA CGA GAT GCT CAT GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389927,18566.1,18565,11.54,19.85,369,100.25,198,581400,71,
        Sheet1,OligoCard,11643249,14912748,188898278,E01,P7-finish_TSBC27-r,CAA GCA GAA GAC GGC ATA CGA GAT AGG AAT GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389928,18639.1,18638,11.38,19.09,356,100.47,190,596000,70,
        Sheet1,OligoCard,11643249,14912748,188898279,E02,P7-finish_TSBC28-r,CAA GCA GAA GAC GGC ATA CGA GAT CTT TTG GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389929,18571.8,18571,11.81,20.43,379,100.15,204,578200,70,
        Sheet1,OligoCard,11643249,14912748,188898280,E03,P7-finish_TSBC29-r,CAA GCA GAA GAC GGC ATA CGA GAT TAG TTG GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389930,18620.9,18620,11.16,18.99,354,100.48,189,587600,70,
        Sheet1,OligoCard,11643249,14912748,188898281,E04,P7-finish_TSBC30-r,CAA GCA GAA GAC GGC ATA CGA GAT CCG GTG GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389931,18605.9,18606,9.43,16.18,301,100.5,161,582500,72,
        Sheet1,OligoCard,11643249,14912748,188898282,E05,P7-finish_TSBC31-r,CAA GCA GAA GAC GGC ATA CGA GAT ATC GTG GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389932,18605.6,18605,13.51,23,428,100,230,587300,71,
        Sheet1,OligoCard,11643249,14912748,188898283,E06,P7-finish_TSBC32-r,CAA GCA GAA GAC GGC ATA CGA GAT TGA GTG GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389933,18645.8,18645,11.89,20.19,376,100.45,201,588800,71,
        Sheet1,OligoCard,11643249,14912748,188898284,E07,P7-finish_TSBC33-r,CAA GCA GAA GAC GGC ATA CGA GAT CGC CTG GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389934,18566.4,18566,15.3,26.47,492,100.27,264,577800,72,
        Sheet1,OligoCard,11643249,14912748,188898285,E08,P7-finish_TSBC34-r,CAA GCA GAA GAC GGC ATA CGA GAT GCC ATG GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389935,18590.5,18590,14.11,24.19,450,100.37,241,583400,72,
        Sheet1,OligoCard,11643249,14912748,188898286,E09,P7-finish_TSBC35-r,CAA GCA GAA GAC GGC ATA CGA GAT AAA ATG GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389936,18622.7,18622,14.37,24.08,448,100.33,240,596700,70,
        Sheet1,OligoCard,11643249,14912748,188898287,E10,P7-finish_TSBC36-r,CAA GCA GAA GAC GGC ATA CGA GAT TGT TGG GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389937,18636.9,18636,15.04,25.77,480,100.27,257,583700,71,
        Sheet1,OligoCard,11643249,14912748,188898288,E11,P7-finish_TSBC37-r,CAA GCA GAA GAC GGC ATA CGA GAT ATT CCG GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389938,18565.9,18565,13.42,22.99,427,100.39,229,583800,71,
        Sheet1,OligoCard,11643249,14912748,188898289,E12,P7-finish_TSBC38-r,CAA GCA GAA GAC GGC ATA CGA GAT AGC TAG GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389939,18614.6,18614,13.91,23.55,438,100.21,235,590800,71,
        Sheet1,OligoCard,11643249,14912748,188898290,F01,P7-finish_TSBC39-r,CAA GCA GAA GAC GGC ATA CGA GAT GTA TAG GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389940,18629.5,18629,15.3,25.77,480,100.27,257,593500,70,
        Sheet1,OligoCard,11643249,14912748,188898291,G01,P7-finish_TSBC40-r,CAA GCA GAA GAC GGC ATA CGA GAT TCT GAG GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389941,18605.5,18605,14.46,24.7,460,100,247,585300,71,
        Sheet1,OligoCard,11643249,14912748,188898292,G02,P7-finish_TSBC41-r,CAA GCA GAA GAC GGC ATA CGA GAT GTC GTC GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389942,18581.8,18581,13.69,23.54,437,100.17,235,581700,71,
        Sheet1,OligoCard,11643249,14912748,188898293,G03,P7-finish_TSBC42-r,CAA GCA GAA GAC GGC ATA CGA GAT CGA TTA GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389943,18589.6,18589,12.03,20.4,379,100,204,589800,70,
        Sheet1,OligoCard,11643249,14912748,188898294,G04,P7-finish_TSBC43-r,CAA GCA GAA GAC GGC ATA CGA GAT GCT GTA GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389944,18605.6,18605,13.49,23.04,429,100.17,230,585500,71,
        Sheet1,OligoCard,11643249,14912748,188898295,G05,P7-finish_TSBC44-r,CAA GCA GAA GAC GGC ATA CGA GAT ATT ATA GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389945,18589.1,18588,13.62,22.9,426,100.44,228,594800,69,
        Sheet1,OligoCard,11643249,14912748,188898296,G06,P7-finish_TSBC45-r,CAA GCA GAA GAC GGC ATA CGA GAT GAA TGA GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389946,18638.7,18638,13.36,22.45,418,100.22,224,595200,70,
        Sheet1,OligoCard,11643249,14912748,188898297,G07,P7-finish_TSBC46-r,CAA GCA GAA GAC GGC ATA CGA GAT TCG GGA GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389947,18630.9,18630,16.76,28.5,531,100,285,587900,71,
        Sheet1,OligoCard,11643249,14912748,188898298,G08,P7-finish_TSBC47-r,CAA GCA GAA GAC GGC ATA CGA GAT CTT CGA GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389948,18566.1,18565,11.41,19.58,363,100.41,195,583000,71,
        Sheet1,OligoCard,11643249,14912748,188898299,G09,P7-finish_TSBC48-r,CAA GCA GAA GAC GGC ATA CGA GAT TGC CGA GTG ACT GGA GTT CAG ACG TGT GCT CTT CCG,236389949,18589.9,18590,11.23,19.24,358,100.21,192,583800,72,"
    
end