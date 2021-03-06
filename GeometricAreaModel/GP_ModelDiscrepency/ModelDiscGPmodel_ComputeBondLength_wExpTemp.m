%% Compute bond length for each interface on a given layer

clc; clear; close all;
% ======================================================================= %
%__________________________       INPUTS     ______________________________
%Process Variables
%__________________________________________________________________________
%Filament dimensions
wth = 0.8e-3; % layer width [meters]
hth = 0.7e-3; % layer height [meters]
layer = 6; % which layer we are looking at for the bond lengths 
% numFilaments-1: (numFilaments-1)th interface on that given layer
num_Filaments = 15;

% Process parameters
ProcessParam = [wth, hth, layer, num_Filaments];
%__________________________________________________________________________
% Material parameters for the bond length model
Surf_tens = 0.29; % Surface tension
b1_ = 0.00345; % Model parameter for temp. dependent surface tension
Visco = 5100; % viscosity
% b2_ = 0.056; % Model parameter for temp. dependent viscosity
% b2_ = 0.02266; % Calibrated with 0.01 std for obs. error for 121 Celcius
% b2_ = 0.016; % Calibrated with 0.01 std for obs. error, necking above temp. 180 Celcius
% b2_ = 0.018; % Calibrated with 0.01 std for obs. error, necking above temp. 150 Celcius
b2_ = 0.014367; % Calibrated for all layers with 0.01 std for obs. error, necking above temp. 150 Celcius
BondModelParam = [Surf_tens, b1_, Visco, b2_];
%__________________________________________________________________________

NumTest = 22;

tic
% The low fidelity 1-D analytical model
% NeckRadii: bond length between two filaments:
%        Output of the heat transfer model that does not consider axial
%        heat conduction & neck growth model, in mm.
[BondLengths] = Neck_Growth_Model(ProcessParam, BondModelParam,NumTest);
toc

% [t210s28_1_temps.mat; t210s28_2_temps.mat; ;
% t234s34_3_temps.mat; t234s34_4_temps.mat; t234s34_2_temps.mat
% t219s23_4_temps.mat; t219s23_5_temps.mat; 
% t242s26_1_temps.mat; t242s26_3_temps.mat; 
% t260s35_1_temps.mat; t260s35_3_temps.mat;
% t223s29_4_temps.mat; t223s29_5_temps.mat; t223s29_6_temps.mat
% t247s37_1_temps.mat; t247s37_2_temps.mat; t247s37_3_temps.mat;
% t255s46_1_temps.mat; t255s46_2_temps.mat; t255s46_3_temps.mat;
% t252s21_1_temps.mat; t252s21_3_temps.mat]

bond_test = [.34036,.34544,.4318,.47752,.52578,.51562,.53594,.44196,.44196,.4191,.44958,.39878,.39624,.40386;...
    0.4299712,0.424307,0.4069334,0.404749,0.45423328,0.4965192,0.476885,0.4200144,0.3517646,0.3564382,0.308864,0.2895854,0.3100324,0.33782;...
    0.4435094,0.4850384,0.518033,0.4221226,0.4375404,0.4354576,0.4451858,0.4208272,0.350139,0.432562,0.3460496,0.2878074,0.3048,0.3305302;...
    0.3683,0.49276,0.54102,0.50292,0.47498,0.45212,0.3945128,0.35814,0.37592,0.37846,0.38354,0.33782,0.3048,0.3175;...
    0.3640836,0.4683506,0.4976114,0.4875276,0.4924806,0.479806,0.4400296,0.3030982,0.2621788,0.2975356,0.3502152,0.2939288,0.2994914,0.2988056;...
    0.36576,0.38339776,0.42164,0.4445,0.45974,0.43942,0.44196,0.34544,0.26162,0.3175,0.35306,0.3175,0.32512,0.31496;...
    
0.37608002,0.45202856,0.46849284,0.48750982,0.47684436,0.53493924,0.5350256,0.55785512,0.49221136,0.4525391,0.42904156,0.36982908,0.38149022,0.34241486;...
0.39234872,0.45067474,0.49032668,0.51163474,0.52864512,0.56627014,0.50580036,0.47223172,0.48743616,0.36446714,0.36421822,0.29066236,0.25915366,0.24448008;...
0.44217082,0.51237896,0.54218078,0.5249545,0.52384706,0.52930806,0.47368206,0.42020744,0.39194232,0.42972482,0.43052746,0.29521404,0.17839436,0.17513046;...
0.41310306,0.46531022,0.49755044,0.51779678,0.50056796,0.48941482,0.49024032,0.35955224,0.34945828,0.36379912,0.44054268,0.38415722,0.24096472,0.1950466;...
0.37077904,0.45975524,0.5076063,0.48265842,0.49868836,0.5224399,0.49926748,0.37275516,0.35809174,0.36031678,0.34369756,0.37786056,0.3447161,0.24307292;...
0.42032174,0.48829468,0.4779899,0.3707003,0.4393565,0.50765964,0.44572936,0.43946318,0.35772852,0.33334452,0.27874722,0.41469564,0.21207476,0.17149826;...

% 234
0.38862,0.4318,0.42164,0.46736,0.47752,0.51816,0.49784,0.5207,0.51562,0.48514,0.4699,0.44704,0.40132,0.40132;...
0.44958,0.55372,0.56134,0.57404,0.5461,0.59182,0.53848,0.54356,0.49276,0.49276,0.46228,0.39624,0.39878,0.46228;...
0.3937,0.55626,0.56388,0.60706,0.56388,0.5334,0.4953,0.45466,0.4826,0.46736,0.4445,0.3175,0.35052,0.38608;...
0.39116,0.51562,0.52578,0.63246,0.60198,0.55118,0.47244,0.4826,0.46736,0.48006,0.46228,0.39116,0.38608,0.381;...
0.4318,0.5207,0.59436,0.50546,0.58928,0.53848,0.4826,0.4699,0.4572,0.4191,0.44958,0.42164,0.3683,0.39116;...
0.36576,0.42418,0.52578,0.52324,0.51816,0.53848,0.50292,0.49276,0.42418,0.4445,0.40132,0.39624,0.3556,0.34036;...

0.49972976,0.49918366,0.5942203,0.60069222,0.59070494,0.58726832,0.55822088,0.6103493,0.58261758,0.56938926,0.53907436,0.49749456,0.43745658,0.44698158;...
0.52517802,0.62820042,0.6191758,0.59592718,0.62732666,0.6025007,0.54346348,0.59428888,0.56614568,0.5799455,0.5107813,0.4629658,0.44630848,0.46021244;...
0.46298866,0.60053728,0.63901828,0.6136259,0.5877814,0.59059318,0.49984152,0.54671214,0.5094859,0.5264023,0.43993562,0.42730166,0.417957,0.4287393;...
.46056804,0.56884062,0.58648346,0.62321948,0.6111494,0.6027928,0.54422802,0.5205222,0.49200562,0.49997614,0.44355258,0.37338254,0.35887914,0.41262554;...
0.42996866,0.53984398,0.62629796,0.62618112,0.57526428,0.53710078,0.52361084,0.52254912,0.43553634,0.49069752,0.47009304,0.40334184,0.35515804,0.40309546;...
0.46550834,0.4894834,0.5535803,0.54369208,0.50246788,0.5346573,0.4884039,0.49898808,0.45423836,0.4741037,0.4466209,0.43531536,0.35483546,0.41630346;...


0.4152773,0.49155096,0.49717198,0.51966622,0.51419252,0.56369966,0.5109845,0.5931154,0.57510426,0.5612638,0.51049936,0.45569124,0.4103751,0.35611562;...
0.45037756,0.49301908,0.5153279,0.57264554,0.56862472,0.57863232,0.49929034,0.41167558,0.45964094,0.45371004,0.44888658,0.40229028,0.38023292,0.3370453;...
0.4773041,0.5073396,0.53200046,0.44604432,0.54495192,0.54479952,0.51606704,0.50926746,0.52959508,0.55216806,0.46471332,0.39617396,0.33512506,0.33582102;...
0.41636696,0.5406644,0.54855364,0.45114464,0.56742838,0.52975764,0.48082962,0.512191,0.4633595,0.49773586,0.46232572,0.42603166,0.31571692,0.28541472;...
0.45110654,0.47657258,0.47276512,0.48886872,0.57792112,0.55242968,0.42865802,0.4861687,0.50082196,0.4987036,0.51308,0.44595796,0.33214564,0.29188664;...
0.40373046,0.48357282,0.47801784,0.45451522,0.56738266,0.55907432,0.49345342,0.44572174,0.43664378,0.4965573,0.47737522,0.44619926,0.35562286,0.32297624;...


% 219
0.43173904,0.48947324,0.50493422,0.50115724,0.5785358,0.61870336,0.58698384,0.62997842,0.59888374,0.6147689,0.60409836,0.49989232,0.41950894,0.5190998;...
0.519049,0.5785739,0.58913014,0.58656982,0.56373014,0.56924956,0.56672988,0.60197746,0.60713874,0.61403738,0.53280564,0.56506872,0.45573442,0.42179748;...
0.46244256,0.61880242,0.58718196,0.6180201,0.61208158,0.61346588,0.58089038,0.58718196,0.5451729,0.56220868,0.5415026,0.5354193,0.4821936,0.4835652;...
0.462407,0.56802274,0.5750433,0.60108592,0.61307218,0.62429644,0.55603902,0.61515244,0.57609994,0.5856859,0.55785258,0.52633118,0.50043842,0.4701286;...
0.49094136,0.5489702,0.55971948,0.58943494,0.5979033,0.5921502,0.56146446,0.57645046,0.59953398,0.58283602,0.54763924,0.5282946,0.48722788,0.46245272;...
0.44813474,0.52808124,0.53608478,0.59736736,0.53349144,0.57643268,0.53484272,0.54762654,0.5466842,0.56845962,0.53246782,0.5312156,0.49306734,0.45228002;...

0.5233416,.5431409,0.55840884,0.56544718,0.58068972,0.62260734,0.60261246,0.60144406,0.5678043,0.60091574,0.55173372,0.54177438,0.49940718,0.55068216;...
0.55108094,0.60392818,0.61627004,0.57293764,0.60960762,0.62648592,0.5920613,0.6319393,0.5831586,0.59348116,0.58632598,0.52845208,0.48192182,0.51847242;...
0.4714621,0.60396882,0.59527186,0.57980326,0.61548264,0.59813952,0.59962796,0.58145172,0.55776114,0.5346573,0.50161698,0.53475128,0.50662332,0.55002684;...
0.457327,0.5545963,0.57232296,0.64092836,0.5923534,0.57948322,0.57315354,0.55140098,0.54995826,0.54556152,0.51027838,0.53184552,0.51762914,0.55068724;...
0.41763696,0.52721764,0.56672988,0.64313054,0.60313062,0.5789295,0.6043041,0.58590688,0.54749954,0.5352542,0.51612038,0.48853598,0.47028608,0.51281584;...
0.43103546,0.54661816,0.52560982,0.56529732,0.55938928,0.57138824,0.58677048,0.56096408,0.5367655,0.57016142,0.54236112,0.46459902,0.38739572,0.40189404;...


% 242
0.54150768,0.54807358,0.55617364,0.52196238,0.535178,0.56175656,0.6057011,0.63568072,0.63545974,0.66295778,0.5824982,0.58606944,0.51688238,0.54834028;...
0.56591708,0.6246876,0.62308486,0.64505586,0.61932566,0.62021974,0.61256164,0.60204096,0.62856872,0.69019166,0.67615816,0.65758568,0.58494422,0.59459622;...
0.54873398,0.62010544,0.6432677,0.67705732,0.69760592,0.66809874,0.65692782,0.67513708,0.6311773,0.64018668,0.64587628,0.6138799,0.59119008,0.60037472;...
0.57531,0.63385446,0.68160646,0.70896734,0.72745092,0.69035676,0.71760314,0.68299584,0.68746624,0.67827652,0.67199002,0.61706252,0.60833,0.60790836;...
0.52084986,0.67046602,0.6428105,0.65814194,0.62973712,0.64737996,0.68527422,0.71647304,0.6893941,0.61033406,0.65337944,0.69042534,0.64621156,0.62503304;...
0.49080928,0.59097164,0.58768996,0.61816234,0.64793622,0.64242188,0.62777624,0.66053462,0.6208141,0.64635888,0.68806822,0.6163056,0.58142886,0.58870596;...


0.5287518,0.4968748,0.5150612,0.538861,0.589407,0.6117336,0.6296914,0.624459,0.6274816,0.5923788,0.6061964,0.5866638,0.5515102,0.5743702;...
0.5696204,0.6041898,0.6063488,0.625983,0.6829044,0.6409436,0.6078728,0.6342634,0.626872,0.6320536,0.6482334,0.6265164,0.5887974,0.6059424;...
0.5416804,0.5944108,0.5917946,0.639318,0.637667,0.658622,0.6274054,0.632714,0.6562344,0.6659372,0.6058408,0.644398,0.6095492,0.5813298;...
0.4873244,0.5570982,0.6359906,0.6411214,0.6935978,0.6525514,0.627507,0.6502654,0.6537706,0.6307328,0.6968744,0.64389,0.6436614,0.583692;...
0.4852416,0.606806,0.6248146,0.6436614,0.6655816,0.684149,0.6857238,0.677926,0.711073,0.6773418,0.6337808,0.620141,0.5934456,0.5736082;...
0.5160264,0.5656834,0.6080252,0.6472682,0.6768592,0.650875,0.5959094,0.6594602,0.6787642,0.6785356,0.6521704,0.6116066,0.573151,0.5358638;...


% 260
0.6142228,0.633476,0.59996324,0.60678314,0.60715144,0.63980314,0.5936361,0.63285116,0.6802755,0.65730628,0.65530476,0.61607446,0.63907162,0.60670694;...
0.5277866,0.61855604,0.62245748,0.59917838,0.6758559,0.66427858,0.62059058,0.4988052,0.5874385,0.62328552,0.6084697,0.6237732,0.62148974,0.58792872;...
0.52666646,0.62297818,0.54336188,0.60486036,0.6612509,0.61420502,0.62617858,0.61985398,0.61020706,0.63487808,0.58953654,0.6246495,0.62301628,0.5326888;...
0.47173896,0.6360668,0.60600844,0.60186316,0.593598,0.61164978,0.63873634,0.6212459,0.62817502,0.64138048,0.6580378,0.65708022,0.59886596,0.53273452;...
0.45095668,0.5270881,0.5405755,0.63368936,0.63870586,0.63371984,0.62752732,0.54779418,0.65295526,0.6223,0.66298572,0.67560952,0.58203592,0.55062882;...
0.43590718,0.50871374,0.53298344,0.59543696,0.53740812,0.52642008,0.55616856,0.56285384,0.572262,0.53415692,0.53847238,0.54762146,0.47713392,0.50653188;...

0.55128414,0.48650398,0.54048914,0.56089804,0.5399151,0.62635638,0.6765925,0.70924928,0.69617336,0.75468988,0.6731762,0.60402216,0.61663834,0.72023224;...
0.52596796,0.57379108,0.56622696,0.57928256,0.63651638,0.62882272,0.56119776,0.62789562,0.62835536,0.5790819,0.60114434,0.5368671,0.5475732,0.5188585;...
0.44283884,0.56929528,0.54906926,0.58209942,0.68918582,0.60204096,0.6223,0.5499989,0.59191906,0.6134608,0.61738764,0.50529998,0.65936876,0.44008548;...
0.42440606,0.60405772,0.53949854,0.578485,0.6052439,0.59277758,0.60433204,0.60858908,0.60664598,0.6283579,0.59077352,0.52494434,0.60546234,0.52882292;...
0.42846752,0.55383938,0.5604002,0.52768246,0.55845456,0.574802,0.60251086,0.5744845,0.61637418,0.618236,0.60318142,0.609854,0.53512212,0.56082946;...
0.45636688,0.53513482,0.5761101,0.61766196,0.58814716,0.56768492,0.5771642,0.57791096,0.5686552,0.57843674,0.56803036,0.6052947,0.60885324,0.53109114;...



0.4350004,0.500507,0.5303901,0.5480177,0.56173878,0.5689981,0.56482742,0.55253636,0.5595874,0.58387234,0.5161915,0.4612513,0.43331384,0.42196766;...
0.44862242,0.58602118,0.61177678,0.61554868,0.61158628,0.60180982,0.57809638,0.57933844,0.52659534,0.54688994,0.53090064,0.47236634,0.44041314,0.4378452;...
0.41031922,0.51967384,0.54105556,0.58049414,0.58480452,0.61651642,0.55451756,0.50642266,0.4874387,0.527685,0.45568362,0.42885868,0.43361102,0.44055284;...
0.3909949,0.52229004,0.56043068,0.53613558,0.56969914,0.56820816,0.51941222,0.51244246,0.47563786,0.48608742,0.42275252,0.3707257,0.35813238,0.37316664;...
0.4121785,0.5350637,0.590423,0.56943752,0.59579002,0.52862988,0.4997196,0.47566834,0.50154332,0.5381117,0.47614586,0.35383216,0.30835092,0.34651696;...
0.38857936,0.49550828,0.54940708,0.56415686,0.53723032,0.54927246,0.51648614,0.49673256,0.48010064,0.50453798,0.47772828,0.44153836,0.3950335,0.34187638;...

0.45974,0.4699,0.47752,0.57404,0.54356,0.56896,0.57912,0.55372,0.57404,0.5334,0.53086,0.46736,0.4826,0.39878;...
0.4410456,0.516001,0.5659882,0.576326,0.5882386,0.551942,0.5441188,0.5353558,0.5128768,0.5272532,0.479044,0.4452366,0.4501388,0.4666488;...
0.4232402,0.4971288,0.4984242,0.5219192,0.540893,0.530987,0.5075936,0.5097018,0.4729988,0.4896358,0.4433316,0.4169156,0.386969,0.410464;...
0.37338,0.46736,0.5588,0.5461,0.51562,0.55372,0.49022,0.46736,0.44704,0.46228,0.4064,0.4318,0.36576,0.34036;...
0.4320032,0.501015,0.4959096,0.5491734,0.5740654,0.5442712,0.4872228,0.5086858,0.4503166,0.4656836,0.4737862,0.4746752,0.318643,0.3021838;...
0.39624,0.46736,0.47498,0.50292,0.5207,0.52324,0.51816,0.49022,0.48006,0.52324,0.54356,0.51054,0.40386,0.38354;...


0.44896786,0.5316982,0.51600862,0.57418478,0.59002422,0.60215272,0.56850026,0.57218326,0.5852541,0.57699402,0.54920388,0.51025044,0.4398899,0.4156329;...
0.45108368,0.52301648,0.537083,0.56547766,0.58947304,0.56915812,0.5715508,0.5461381,0.52749704,0.5259832,0.4974844,0.47360078,0.42066464,0.40232076;...
0.46949868,0.49494948,0.53362606,0.51970686,0.57227216,0.55766716,0.55334662,0.52743354,0.52559458,0.51816254,0.5051425,0.41399714,0.38491922,0.37633148;...
0.50288698,0.55566564,0.60553092,0.58313574,0.58095642,0.51802284,0.53081174,0.58198004,0.57529984,0.52344574,0.54884574,0.51365912,0.3689477,0.3999611;...
0.4185158,0.56053228,0.62021466,0.58981594,0.60616846,0.58852816,0.52083462,0.48990758,0.50382424,0.51381406,0.56691784,0.58566304,0.42553128,0.45587412;...
0.46973998,0.53179472,0.52980336,0.56693562,0.56510174,0.58839862,0.53193696,0.47608236,0.4984369,0.47954692,0.49264062,0.48007778,0.37756592,0.40466772;...



% 247
0.48697642,0.54173628,0.58204354,0.6334506,0.71483728,0.70277228,0.686181,0.685673,0.69745606,0.7117207,0.6978523,0.65822068,0.6735318,0.64583056;...
0.44146216,0.5521833,0.56614314,0.63512192,0.6039866,0.55593488,0.55131462,0.57001918,0.55765192,0.56694324,0.5634482,0.5281803,0.51191414,0.520954;...
0.44977304,0.49388776,0.5610225,0.60408566,0.56909462,0.59820302,0.57758838,0.54587394,0.56660796,0.53937408,0.49987708,0.47286418,0.43899582,0.46756828;...
0.47943516,0.54695598,0.60337192,0.61815472,0.63889128,0.59216798,0.5971667,0.54893972,0.56864758,0.60009786,0.51827938,0.47008034,0.45374814,0.46762416;...
0.44791884,0.56211724, 0.5443347,0.57093612,0.4236974,0.59906408,0.48954944,0.50017172,0.47689516,0.54124352,0.45867574,0.47834296,0.37190172,0.44401232;...
0.4414266,0.51579272,0.54539642,0.6175502,0.59111134,0.5808218,0.52012596,0.51555904,0.55867808,0.55106316,0.49651158,0.502412,0.4172331,0.37376862;...

0.4783709,0.54935882,0.55651146,0.64164464,0.63561468,0.57915556,0.60948316,0.62603888,0.618998,0.53534564,0.66073274,0.63289942,0.61359034,0.55226458;...
0.4721606,0.5408676,0.5916422,0.6209538,0.6417564,0.5880862,0.5044694,0.554736,0.5155438,0.5381498,0.4979416,0.4823714,0.4460494,0.454533;...
0.4148836,0.519303,0.5697982,0.5690108,0.5335016,0.5665216,0.54102,0.5126228,0.5387086,0.5387594,0.5606034,0.4903216,0.4509516,0.3678682;...
0.49022,0.48768,0.49276,0.50292,0.4953,0.56134,0.51054,0.51054,0.5334,0.53086,0.51816,0.48514,0.40894,0.43942;...
0.4433824,0.5653786,0.5837936,0.632079,0.6243828,0.6126734,0.483235,0.4660392,0.450596,0.525272,0.5623306,0.5513324,0.3991356,0.4074414;...
0.40132,0.49022,0.5222621,0.56388,0.60706,0.52578,0.46736,0.50038,0.51308,0.53848,0.50292,0.49784,0.38608,0.34036;...

0.50022252,0.49384966,0.58049414,0.62350396,0.6790309,0.65327784,0.61936122,0.64331088,0.66291206,0.60349638,0.61517784,0.59365642,0.61863478,0.6113145;...
0.54656736,0.532003,0.57605168,0.59105038,0.60296044,0.60901326,0.56738012,0.6009767,0.58840624,0.58079132,0.58437526,0.57614058,0.48996346,0.51558444;...
0.50810922,0.56249824,0.57543954,0.62242192,0.53493924,0.59573668,0.58591196,0.58526934,0.60312808,0.55795164,0.50588418,0.52193952,0.48288702,0.5037328;...
0.5062474,0.62476888,0.61146182,0.62479936,0.63650622,0.59872118,0.53991256,0.58396886,0.5424043,0.5315204,0.48626268,0.48746918,0.4783074,0.48946816;...
0.39552118,0.6241669,0.6245987,0.65450974,0.63858902,0.62845442,0.55693056,0.58976514,0.56732678,0.56843168,0.53547264,0.47325534,0.39638478,0.4311777;...
0.42885106,0.53285644,0.55515764,0.57625996,0.58723276,0.54722268,0.50147474,0.56173624,0.52706778,0.5428488,0.4799203,0.48410622,0.43543982,0.45934376;...

% 255
0.4003802,0.46118272,0.52152296,0.55893716,0.5373243,0.54146196,0.52077874,0.51377596,0.50603658,0.4873244,0.4704969,0.40757856,0.33943544,0.34058098;...
0.45451522,0.52318666,0.55244492,0.59022996,0.54899306,0.50519076,0.31620206,0.38583108,0.38320472,0.42009822,0.38410388,0.34455354,0.28713684,0.28238196;...
0.45597318,0.59106816,0.5774944,0.62265306,0.57917334,0.47201328,0.25991312,0.3564382,0.3927094,0.37080952,0.36638992,0.34158174,0.30037786,0.25989026;...
0.42583608,0.5380609,0.58333386,0.51698144,0.6286373,0.46335188,0.35287204,0.36197794,0.32757618,0.39344854,0.36700714,0.37292026,0.26477722,0.23824692;...
0.4367911,0.45451522,0.52296314,0.59928252,0.60136024,0.44869608,0.39428166,0.33972246,0.35554666,0.4014597,0.41152826,0.34999168,0.26832306,0.24936704;...
0.39101268,0.44653708,0.51600608,0.50715418,0.57846976,0.51341274,0.34140902,0.40498014,0.38158166,0.44459652,0.4210939,0.37876988,0.27357578,0.26587704;...


0.45655738,0.46999652,0.51566572,0.518541,0.5208016,0.62770004,0.54172104,0.51536346,0.52565046,0.50227992,0.40564562,0.33947608,0.35683444,0.32060896;...
0.5926709,0.54748684,0.56901588,0.50802286,0.60945014,0.47397162,0.37812472,0.37754814,0.43219624,0.47982124,0.38938454,0.34812986,0.31689802,0.292481;...
0.47640494,0.55485792,0.5868035,0.59256168,0.55903114,0.43652694,0.35139122,0.29683964,0.3700272,0.43107356,0.3753612,0.33432496,0.3070606,0.31698946;...
0.46999652,0.55596536,0.56137048,0.54846728,0.60914534,0.46469808,0.35194748,0.34808414,0.35495738,0.37662358,0.38639496,0.36261548,0.33427416,0.3013329;...
0.4962398,0.53288946,0.57884568,0.6276721,0.56389778,0.47779178,0.36779454,0.3706368,0.4275074,0.43045634,0.34790634,0.37415216,0.35279076,0.3376168;...
0.38172644,0.51709066,0.5737479,0.53117242,0.54367684,0.51700938,0.33390586,0.39797228,0.51054254,0.43641772,0.38338252,0.36024566,0.38993572,0.33885886;...


0.42634662,0.44368974,0.47155608,0.53457856,0.53488082,0.52482496,0.4892548,0.53529992,0.51038252,0.48081438,0.45268896,0.45268896,0.40779954,0.4644136;...
0.4119372,0.5402453,0.55093108,0.58385456,0.55422292,0.35073082,0.29879544,0.38920674,0.41234106,0.45925486,0.40998394,0.38902386,0.38902894,0.4012311;...
0.44477686,0.55151274,0.52327556,0.61712094,0.57570116,0.3728593,0.21942044,0.362966,0.35028886,0.41468294,0.40058086,0.39137844,0.35539934,0.35438842;...
0.44995084,0.59001914,0.57839864,0.5419471,0.59413902,0.42091102,0.27862276,0.36215574,0.41688258,0.38352222,0.3281807,0.34272474,0.3269996,0.34674302;...
0.45231812,0.5679948,0.56512968,0.62465204,0.60005468,0.47823628,0.23387812,0.3785362,0.39737538,0.43279314,0.40831262,0.34986722,0.33042098,0.31650432;...
0.43450256,0.54148482,0.54622954,0.56114442,0.56582564,0.491998,0.31589218,0.40323008,0.4371594,0.4316476,0.36793424,0.40865298,0.3256534,0.324231;...

% 252
0.5518912,0.6269736,0.657606,0.68438776,0.6373876,0.6759194,0.70395338,0.61932312,0.70766178,0.70857872,0.64976502,0.6629146,0.62848236,0.74328782;...
0.57904888,0.59551824,0.6766306,0.66521838,0.68699888,0.72004174,0.78422754,0.72168004,0.69519546,0.69670168,0.59077352,0.63762128,0.53293772,0.71866506;...
0.56349646,0.63391034,0.66410586,0.65397634,0.64886078,0.67883532,0.67612006,0.64920368,0.62444884,0.64120776,0.63840106,0.63662306,0.63966852,0.66999104;...
0.5063109,0.61478668,0.71725028,0.69045836,0.76191364,0.64057784,0.73488042,0.70996302,0.70214744,0.65829688,0.6385814,0.62281054,0.581787,0.60792614;...
0.55894986,0.66879978,0.44379642,0.70409054,0.72319896,0.75304904,0.70470268,0.71902828,0.66672968,0.65223898,0.58577226,0.56827166,0.59377834,0.61651896;...
0.48673004,0.58683906,0.66327528,0.63945262,0.6787769,0.66257424,0.72108822,0.69915278,0.75986894,0.73452736,0.69030596,0.61689742,0.58194448,0.65120012;...

0.55738522,0.61043566,0.61152024,0.57534302,0.59857386,0.57761886,0.65809368,0.68104766,0.6301486,0.53376068,0.56312308,0.5386959,0.52199794,0.66555112;...
0.61183012,0.58129932,0.66402458,0.5863463,0.71343774,0.6843014,0.6476619,0.57585102,0.67907154,0.67721226,0.60123578,0.69242686,0.76477876,0.73348088;...
0.53121814,0.56947816,0.62403228,0.6691122,0.6726301,0.66238374,0.66779902,0.70857872,0.61658246,0.56339994,0.6538595,0.7207758,0.69273928,0.55965852;...
0.50919888,0.565531,0.7898384,0.6590792,0.8188579,0.73296526,0.65107566,0.66190368,0.72536812,0.7341108,0.71190612,0.68651374,0.60830206,0.5850763;...
0.58844942,0.50721768,0.6380099,0.54840632,0.68866258,0.74488802,0.76293472,0.68281296,0.77771498,0.80212438,0.5806821,0.66308986,0.66989198,0.60441078;...
0.52262532,0.6092825,0.75055984,0.77821536,0.75009248,0.69242178,0.58811414,0.6961251,0.65913254,0.62085982,0.6961251,0.56816244,0.47276512,0.45423328];




% MidGapsM=BondLengths(:,7:8);
% ReOrderM=reshape(MidGapsM,6,126/3);
% Resh7Gap=reshape(ReOrderM(:,1:21),1,21*6);
% 
% % kk=0;
% figure;
% % m = ['h--','o--','*--','.','x','s','d','^','v','>','<','p','h','o','*','.','x','s','d','^','v','>','<','p'];
% for ii=6:6:126
% %     kk=kk+1;
%     plot(ii-5:ii,Resh7Gap(ii-5:ii),'--.','Markersize',12)
%     hold on;
% end
% % axis tight;
% % set(gcf, 'Position',  [200, 300, 900, 600])
% % set(gcf, 'PaperPosition', [0 0 7 5]); %Position plot at left hand corner with width 5 and height 5.
% % set(gcf, 'PaperSize', [7 5]); %Set the paper to have width 5 and height 5.
% 
% 
% MidGaps=bond_test(:,7:8);
% ReOrder=reshape(MidGaps,6,126/3);
% ReshGap=reshape(ReOrder(:,1:21),1,21*6);
% 
% % kk=0;
% figure;
% % m = ['h--','o--','*--','.','x','s','d','^','v','>','<','p','h','o','*','.','x','s','d','^','v','>','<','p'];
% for ii=6:6:126
% %     kk=kk+1;
%     plot(ii-5:ii,ReshGap(ii-5:ii),'--.','Markersize',12)
%     hold on;
% end


% [t210s28_1_temps.mat; t210s28_2_temps.mat; ;
% t234s34_3_temps.mat; t234s34_4_temps.mat; t234s34_2_temps.mat
% t219s23_4_temps.mat; t219s23_5_temps.mat; 
% t242s26_1_temps.mat; t242s26_3_temps.mat; 
% t260s35_1_temps.mat; t260s35_3_temps.mat;
% t223s29_4_temps.mat; t223s29_5_temps.mat; t223s29_6_temps.mat
% t247s37_1_temps.mat; t247s37_2_temps.mat; t247s37_3_temps.mat;
% t255s46_1_temps.mat; t255s46_2_temps.mat; t255s46_3_temps.mat;
% t252s21_1_temps.mat; t252s21_3_temps.mat]
Sample_Temp_Speed = 1.0*[210 28; 210 28;...
                         234 34; 234 34; 234 34;...
                         219 23; 219 23;...
                         242 26; 242 26;...
                         260 35; 260 35;...
                         223 29; 223 29; 223 29;...
                         247 37; 247 37; 247 37;...
                         255 46; 255 46; 255 46;...
                         252 21; 252 21];

% Model discrepency: delta =  y_d - y_m - eps_obs
delta = bond_test - BondLengths - normrnd(0,0.05);

% Build a Surrogate model (GP) for delta
% Inputs: [Nozzle temp, printer speed, layer #, filament #]
% in [Celcius, mm/s, ID, ID]
for iii=1:NumTest
    Inp((iii-1)*layer*(num_Filaments-1)+1:iii*layer*(num_Filaments-1),:) = [Sample_Temp_Speed(iii,1)*ones(layer*(num_Filaments-1),1) ...
        Sample_Temp_Speed(iii,2)*ones(layer*(num_Filaments-1),1) ...
        zeros(layer*(num_Filaments-1),2)];
end

% Prediction inputs are x&y coordinates of vertical bond (ly) locations
% x,y coordinate of layer 1 & interface 1 (vertical)
x = wth*1e3; y = 0.5*hth*1e3; % in mm
iki_y=y*2;

kk=0;
for iii=1:NumTest
    for jj=1:layer
        for ii=1:num_Filaments-1
            kk=kk+1;
            % use x & y coordinates of vertical bonds as predict variables
            Inp(kk,3:4) = [ii*x y+(jj-1)*iki_y];
        end
    end
end


% Output: delta, in [mm]
Out=reshape(delta',NumTest*layer*(num_Filaments-1),1);

allData = [Inp Out];
%%
% -------------------------------------------------------------------------
%                               GP Model
% -------------------------------------------------------------------------
nl = length(Inp);

% % randomly select 95% to be training set for GP model
% num_train = round(0.95*nl); 
% idx_ = randperm(nl);
% 
% % Use the first 95% to train the GP model
% idx_train = idx_(1:num_train);
% allData_Train = allData(idx_train, :);
% 
% % The rest will be used to test the GP model
% idx_test = idx_((num_train + 1):end);
% allData_Test = allData(idx_test, :);



% Select test set for GP model and keep it same
NumGapsIncrement = 14*4;
GapId = 3; % 7 and 8 are the middle gaps
Test_set = GapId:NumGapsIncrement:nl;
all_set = 1:nl;
rem_set = setdiff(all_set,Test_set);


% Use these to train the GP model
% randomly sample some percent of available training data
Ratio = 0.7;
Train_set = randsample(rem_set,round(Ratio*length(rem_set)));
allData_Train = allData(Train_set, :);
% Test data
allData_Test = allData(Test_set, :);



% % Select training set for GP model
% num_train = round(0.8*nl); 
% idx_ = 1:nl;
% 
% % Use these to train the GP model
% idx_train = idx_(1:num_train);
% allData_Train = allData(idx_train, :);
% 
% % Last 100 points will be used to test the GP model
% N_test = 100;
% idx_test = idx_(end-N_test-1:end);
% allData_Test = allData(idx_test, :);




% save 'allData_Train.data' allData_Train -ascii
% tbl = readtable('allData_Train.data','Filetype','text',...
% 'ReadVariableNames',false);
% tbl.Properties.VariableNames = {'Temperature','Speed','x','y','ModelDiscrepency'};

% gprMdl = fitrgp(tbl,'ModelDiscrepency','KernelFunction','ardsquaredexponential',...
%       'FitMethod','exact','PredictMethod','exact','Standardize',1);
  
% initialize the kernel parameters
sigma0_Lb = std(allData_Train(:,end));
sigmaTGA0_Lb = sigma0_Lb;
d = size(allData_Train(:,1:end-1),2);
sigmaM0_Lb = 1*ones(d,1);

% fitting using fitrgp
gprMdl = fitrgp(allData_Train(:,1:end-1),allData_Train(:,end),'Basis','constant',...
                   'FitMethod','exact','PredictMethod','exact',...
                   'KernelFunction','ardsquaredexponential',...
                   'KernelParameters',[sigmaM0_Lb;sigmaTGA0_Lb],...
                   'Sigma',sigma0_Lb,'Standardize',1);

% % Model parameters
% % Trend Function
% Beta_Lb= gprMdl.Beta;
% % The kernel parameters.
% sigmaM_Lb = gprMdl.KernelInformation.KernelParameters(1:end-1,1);
% sigmaTGA_Lb = gprMdl.KernelInformation.KernelParameters(end);
% % Estimated noise standard deviation (sigma_n)
% sigma_Lb  = gprMdl.Sigma;


  
xtest=allData_Test(:,1:end-1);
ytest=allData_Test(:,end);

% test the GP model
[delta_pred, delta_pred_sd, delta_pred_int] = predict(gprMdl,xtest);

% Compute the regression error on the test data
L = loss(gprMdl, xtest, ytest)

d = size(xtest,2);


mean_deltapred=mean(delta_pred)
std_deltapred=std(delta_pred)


% -----------------------------
%   Plot GP model test result
% -----------------------------
figure()
% plot(1:length(delta_pred), ytest, 'or', 1:length(delta_pred), delta_pred, '*b');
% errorbar(1:length(delta_pred), delta_pred,delta_pred_sd,'-b')
boundedline(1:length(delta_pred),delta_pred,1.96*delta_pred_sd, '-bo', 'alpha');hold on;
plot(1:length(delta_pred), ytest, '.m','MarkerSize', 20);
legend('95% Confidence interval','GP predictions', 'Data')
xlabel('Test points', 'FontName', 'Times New Roman', ...
       'FontSize',16,'Color','k', 'Interpreter', 'tex');
ylabel('\delta','FontName', 'Times New Roman', ...
       'FontSize',16,'Color','k', 'Interpreter', 'tex');

axis tight;
set(gcf, 'Position',  [200, 300, 900, 600])
set(gcf, 'PaperPosition', [0 0 7 5]); %Position plot at left hand corner with width 5 and height 5.
set(gcf, 'PaperSize', [7 5]); %Set the paper to have width 5 and height 5.






[delta_m, delta_all_sd] = predict(gprMdl,Inp);
% DeltaMean=reshape(delta_m,(num_Filaments-1),NumTest*layer);
% DeltaMean=DeltaMean';
% DeltaStd=reshape(delta_all_sd,(num_Filaments-1),NumTest*layer);
% DeltaStd=DeltaStd';


% % calculate covariance matrix k(xi,xj;theta)
% kfcn = gprMdl.Impl.Kernel.makeKernelAsFunctionOfXNXM(gprMdl.Impl.ThetaHat);
% K = kfcn(Inp(:,:),Inp(:,:));

% bond length model predictions
Y_m=reshape(BondLengths',NumTest*layer*(num_Filaments-1),1);
Y_D=reshape(bond_test',NumTest*layer*(num_Filaments-1),1);

% Y_D= N( Y_m + DeltaMean, K + eps_obs*I) -> You Ling paper 2014, Eq. (12)
Y_pred=normrnd(Y_m + delta_m, delta_all_sd);
% Y_pred = mvnrnd(Y_m + delta_m, sqrt(K));

% error = g_true-g_pred
Err = Y_D-Y_pred;
figure;
plot(Err,'.')

mean_Err_mf = mean(Err) 
std_Err_mf = std(Err)




% compare mean measurement for each layer with model prediction
% Take mean for each layer for model
DeltaMean=reshape(delta_m,(num_Filaments-1),NumTest*layer);
DeltaMean=DeltaMean';
% mean model form error for each layer (each row is one layer)
mean_DeltaMean=mean(DeltaMean,2);

% Avg. Variances and then sqrt to get std for each layer
DeltaStd=reshape(delta_all_sd,(num_Filaments-1),NumTest*layer);
DeltaStd=DeltaStd';
DeltaVar=DeltaStd.^2;
mean_DeltaVar=mean(DeltaVar,2);
mean_DeltaStd = sqrt(mean_DeltaVar);

% Take mean for each layer for model prediction (neck growth model)
mean_BondLengths=mean(BondLengths,2);

% Take mean for each layer for measurements
mean_bond_test=mean(bond_test,2);

% y_true or g_pred
mean_Y_pred=normrnd(mean_BondLengths + mean_DeltaMean, mean_DeltaStd);


% error = g_true-g_pred
layerbylayer_Err = mean_bond_test-mean_Y_pred;
figure;
plot(layerbylayer_Err,'.')

mean_layer_Err_mf = mean(layerbylayer_Err) 
std_layer_Err_mf = std(layerbylayer_Err)




% ======================================================================= %

function[AllBondLengths] = Neck_Growth_Model(ProcessParam,inputs,NumTest)

%Filament dimensions
w = ProcessParam(1); % Layer Thickness (meters)
h = ProcessParam(2); % Layer Height (meters)
layer = ProcessParam(3); % considered layer number
numFilaments = ProcessParam(4); % considered interface number on that layer
% numFilaments - 1 = interface number (ranging from 1-14 for 15 filaments)
% for that given layer

KK = 273.15; % 0 Celcius in K
% convert Celcius to Kelvin

% ======================================================================= %
%% Experiment
%% This will plot the temperatures at line B (x = 175 pixels)
% Row pixels that are manually chosen which represents the interface 
% between lines and column pixels represent point B
row=[41,38,35,32,30,27,25,22,20,18,15,13,10,8];
% start_frame=19; % interface between Line 1&2
% row=8:10; start_frame=154; %Line 17
% col=175; 

FullBondLengths=zeros(layer,numFilaments-1);
AllBondLengths=zeros(NumTest*layer,numFilaments-1);

% [t210s28_1_temps.mat; t210s28_2_temps.mat; ;
% t234s34_3_temps.mat; t234s34_4_temps.mat; t234s34_2_temps.mat
% t219s23_4_temps.mat; t219s23_5_temps.mat; 
% t242s26_1_temps.mat; t242s26_3_temps.mat; 
% t260s35_1_temps.mat; t260s35_3_temps.mat;
% t223s29_4_temps.mat; t223s29_5_temps.mat; t223s29_6_temps.mat
% t247s37_1_temps.mat; t247s37_2_temps.mat; t247s37_3_temps.mat;
% t255s46_1_temps.mat; t255s46_2_temps.mat; t255s46_3_temps.mat
% t252s21_3_temps.mat]
Temp.S1 = load('..\..\Experiment_Analytical_Abaqus\T210S28-selected\t210s28_1_temps.mat');
Temp.S2 = load('..\..\Experiment_Analytical_Abaqus\T210S28-selected\t210s28_2_temps.mat');
Temp.S3 = load('..\..\Experiment_Analytical_Abaqus\T234S34-selected\t234s34_3_temps.mat');
Temp.S4 = load('..\..\Experiment_Analytical_Abaqus\T234S34-selected\t234s34_4_temps.mat');
Temp.S5 = load('..\..\Experiment_Analytical_Abaqus\T234S34-selected\t234s34_2_temps.mat');
Temp.S6 = load('..\..\Experiment_Analytical_Abaqus\T219S23-selected\t219s23_4_temps.mat');
Temp.S7 = load('..\..\Experiment_Analytical_Abaqus\T219S23-selected\t219s23_5_temps.mat');
Temp.S8 = load('..\..\Experiment_Analytical_Abaqus\T242S26-selected\t242s26_1_temps.mat');
Temp.S9 = load('..\..\Experiment_Analytical_Abaqus\T242S26-selected\t242s26_3_temps.mat');
Temp.S10 = load('..\..\Experiment_Analytical_Abaqus\T260S35-selected\t260s35_1_temps.mat');
Temp.S11 = load('..\..\Experiment_Analytical_Abaqus\T260S35-selected\t260s35_3_temps.mat');
Temp.S12 = load('..\..\Experiment_Analytical_Abaqus\T223S29-selected\t223s29_4_temps.mat');
Temp.S13 = load('..\..\Experiment_Analytical_Abaqus\T223S29-selected\t223s29_5_temps.mat');
Temp.S14 = load('..\..\Experiment_Analytical_Abaqus\T223S29-selected\t223s29_6_temps.mat');
Temp.S15 = load('..\..\Experiment_Analytical_Abaqus\T247S37-selected\t247s37_1_temps.mat');
Temp.S16 = load('..\..\Experiment_Analytical_Abaqus\T247S37-selected\t247s37_2_temps.mat');
Temp.S17 = load('..\..\Experiment_Analytical_Abaqus\T247S37-selected\t247s37_3_temps.mat');
Temp.S18 = load('..\..\Experiment_Analytical_Abaqus\T255S46-selected\t255s46_1_temps.mat');
Temp.S19 = load('..\..\Experiment_Analytical_Abaqus\T255S46-selected\t255s46_2_temps.mat');
Temp.S20 = load('..\..\Experiment_Analytical_Abaqus\T255S46-selected\t255s46_3_temps.mat');
Temp.S21 = load('..\..\Experiment_Analytical_Abaqus\T252S21-selected\t252s21_1_temps.mat');
Temp.S22 = load('..\..\Experiment_Analytical_Abaqus\T252S21-selected\t252s21_3_temps.mat');


for iii=1:NumTest
    % import temperature data
    temps = Temp.(strcat('S', int2str(iii)));

    for jj=1:layer

        % Note: numFilaments-1 = size(row,2)
        pixeltemp = zeros(size(row,2), size(temps.(strcat('layer', int2str(jj))),3));
        Int_temps_exp = zeros(size(row,2), size(temps.(strcat('layer', int2str(jj))),3));
        FrameIdx=zeros(1,numFilaments-1);
        kk=1;
        for rr = 1:size(row,2)
            % convert Celcius to Kelvin, 174:180 -> find the max temp. near mid
            % point, col=175 is not always the mid point as we go to next lines bc. of
            % angle of the camera
            pixeltemp(rr, :) = max(temps.(strcat('layer', int2str(jj)))(row(rr), 174:180, :))+KK;
            if rr==1
                [~,sortIdx]=sort(pixeltemp(rr, :));
                FrameIdx(rr)=sortIdx(end);
            else
                [~,sortIdx]=sort(pixeltemp(rr, :));
                while (sortIdx(end-kk)-FrameIdx(rr-1))<2 % make sure that adjacent frames are not taken
                    kk=kk+1;
                end
                FrameIdx(rr) = sortIdx(end-kk);
            end
            % interface temperatures at point B
            Int_temps_exp(rr, FrameIdx(rr)-(FrameIdx(1)-1):end-(FrameIdx(1)-1)) = pixeltemp(rr, FrameIdx(rr):end);
        end

        start_frame = 1;
        final_frame = size(Int_temps_exp,2);
        freq = 10.5; % frequency of frames
        exp_time = start_frame/freq:1/freq:final_frame/freq;

        tfinal=exp_time(end);

        NeckRadius=zeros(1,numFilaments-1);
        % 1st non-zero temp. data column index for the 1st interface of the experiment
        firstEl=1; 
        % Neck growth calculation using the temperature field from experiment
        for rr=1:numFilaments-1 % loop over each interface for layer 1
            num=size(Int_temps_exp,2)-FrameIdx(rr)+1;
            dt=tfinal/num;

            if rr~=1
                % starting time index (col. no) for that interface
                firstEl=firstEl+FrameIdx(rr)-FrameIdx(rr-1);
            end
            % interface temperature for experiment
            T = Int_temps_exp(rr,firstEl:end);    

            % Neck growth calculation using the experiment temperature
            % ==================================================================== %
            % automatic step size Runge-Kutta-Fehlberg integration method
            % (Burden and Faires, 1985)
            % To overcome numerical instabilities when theta = 0, the initial BC.
            % is fixed at a time value slightly different than zero and the
            % corresponding value of theta is determined from Eq. 15

            % They found that the majority of neck growth and sintering in the ABS
            % fibers occurred when the interphase temperature was above 200�C,
            % which meant (based on heat transfer analysis and confirmed by
            % experiments) that the nozzle temperature had a large effect on
            % sintering while environment temperature had little effect.

            % In which delta is time step. For this case, delta is set equal to 2*dt.
            % dt is the time step that is used for the interval loop
            % ==================================================================== %

            % ao = w/2; % initial radius: half of layer width in meters
        %     ao = sqrt(w/2*h/2) % initial radius: half of layer width in meters
            aa=w/2; bb=h/2;
            % initial radius of an ellipse at 45 degrees
            ao=aa*bb/sqrt(aa^2*sin(0.25*pi)^2+bb^2*cos(0.25*pi)^2); % in [m]
            % Material properties - ABS
            %Surface tension
            gamma = inputs(1);
            % gamma=.029; % N/m for ABS P400 at 240 celcius
            % gamma=.047; % N/m for ABS P400 at 220 celcius
            % gamma=.054; % N/m for ABS P400 at 200 celcius
            % with a temp. dependent of Delta Gamma/ Delta T = - 0.000345 N/m/K
            b1=inputs(2);
            % b1 = 0.00345;
            Delta_Gamma = -b1*ones(1,ceil(tfinal/dt)+1);

            % Temperature dependent viscosity
            % eta_r=5100; % %Viscosity at temp 240 celc
            eta_r = inputs(3);
            % b2 = 0.056; % model parameter for temp dependent viscosity
            b2 = inputs(4); % model parameter for temp dependent viscosity

            Kel = 273.15; % Kelvin conversion
            [~,idx]=min(abs(T-(240+Kel)));
            if T(1)>240+Kel
                Delta_Gamma(1:idx) = -0.0005;
                % Delta_Gamma(1:idx) = -0.000000001;
            end

            T_r_C = 240; % reference temperature in C
            T_r = T_r_C+Kel; % in K

            Eta(1) = eta_r*exp(-b2*(T(1)-T_r));
            Gamma(1) = gamma + Delta_Gamma(1) * (T(1)-T_r);

            Eta(2) = eta_r*exp(-b2*(T(2)-T_r));
            Gamma(2) = gamma + Delta_Gamma(2) * (T(2)-T_r);

            theta(1)=0;
            t_bond(1)=0;

            theta(2)=sqrt(2*(dt)*Gamma(2)/(Eta(2)*ao)); % Eq. 15
            t_bond(2)=2*dt;

            for jjj=4:2:(tfinal/dt-1)
                delta_t=2*dt;
                t_bond(jjj/2+1)=t_bond(jjj/2)+delta_t;
                %k1 calculation at t_bond(i/2)
                eta_1=eta_r*exp(-b2*(T(jjj-1)-T_r));
                gamma_1 = gamma+ Delta_Gamma(jjj-1) * (T(jjj-1)-T_r);
                theta_1=theta(jjj/2);
                k1=(gamma_1/(3*ao*eta_1*sqrt(pi)))*((pi-theta_1)*cos(theta_1)+...
                    sin(theta_1))*((pi-theta_1+sin(theta_1)*(cos(theta_1)))^(1/2))/...
                    (((pi-theta_1)^2)*((sin(theta_1))^2));

                %k2 calculation
                eta_2=eta_r*exp(-b2*(T(jjj)-T_r));
                gamma_2 = gamma+ Delta_Gamma(jjj) * (T(jjj)-T_r);
                theta_2=theta(jjj/2)+dt*k1;
                k2=(gamma_2/(3*ao*eta_2*sqrt(pi)))*((pi-theta_2)*cos(theta_2)+...
                    sin(theta_2))*((pi-theta_2+sin(theta_2)*(cos(theta_2)))^(1/2))/...
                    (((pi-theta_2)^2)*((sin(theta_2))^2));
                %k3 calculation
                eta_3=eta_2;
                gamma_3=gamma_2;
                theta_3=theta(jjj/2)+dt*k2;
                k3=(gamma_3/(3*ao*eta_3*sqrt(pi)))*((pi-theta_3)*cos(theta_3)+...
                    sin(theta_3))*((pi-theta_3+sin(theta_3)*(cos(theta_3)))^(1/2))/...
                    (((pi-theta_3)^2)*((sin(theta_3))^2));
                %k4 calculation
                eta_4=eta_r*exp(-b2*(T(jjj+1)-T_r));
                gamma_4 = gamma+ Delta_Gamma(jjj+1) * (T(jjj+1)-T_r);
                theta_4=theta(jjj/2)+2*dt*k3;
                k4=(gamma_4/(3*ao*eta_4*sqrt(pi)))*((pi-theta_4)*cos(theta_4)+...
                    sin(theta_4))*((pi-theta_4+sin(theta_4)*(cos(theta_4)))^(1/2))/...
                    (((pi-theta_4)^2)*((sin(theta_4))^2));

                % theta
                theta(jjj/2+1)=theta(jjj/2)+(1/6)*delta_t*(k1+2*k2+2*k3+k4);
            end
            % y = a*sin(theta)

            % bond length = initial radius*sin(angle)
            bondLength=ao*sin(theta);

            % find the time when temperature reaches 112 celcius
            index1=find(150+KK>T,1,'first');

            if rr==1
                % find the time index that corresponds to the same time
                [~,index2]=min(abs(exp_time(index1)-t_bond));
            else
                % find the time index that corresponds to the same time
                [~,index2]=min(abs(exp_time(index1+firstEl-1)-t_bond));
            end

            % save neck radius for each interface on a given layer
            NeckRadius(rr) = 2*bondLength(index2)*1e3; % neck radius in mm
        end
        FullBondLengths(jj,:) = NeckRadius;
    end
    AllBondLengths((iii-1)*layer+1:iii*layer,:) = FullBondLengths;
end

end


    
    
    