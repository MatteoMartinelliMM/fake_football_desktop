//region shared pref key
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

const String GAME_STATE = 'GAME_STATE';
//end region

//region asset filename
const String BASE_PATH = 'assets/squad/';
const String ROOKIE_CARD_YELLOW = 'assets/squad/rookie/yellowCardRookie.png';
const String ROOKIE_CARD_GREEN = 'assets/squad/rookie/greenCardRookie.png';
const String CARD_FORMAZIONE = 'cardFormazione';
const String HIGHLIGHTS_VIDEO_PREFIX = 'highlights_';
const String CARD_PORTIERE = 'cardPortiere';
const String CARD_SOCIAL = 'cardSocial';
const String PLAYER_INTERO = 'intero';
const String PLAYER_MEZZO_BUSTO = 'mezzobusto';
const String PLAYER_MEZZO_BUSTO_NAMED = 'mezzobustoNamed';
const String PLAYER_TAGLIATO = 'tagliato';
const String PLAYER_BG = 'playerBg';
const String PLAYER_STATS = 'playerStats';
const String TESTA = 'testa';
const String YELLOW_F = 'Y';
const String GREEN_F = 'G';

//endregion

//region ripeilogo
const String ALL_STATISTICS_SOCIALS = 'ALL_STATISTICS_SOCIALS';
const String ALL_STATISTICS = 'ALL_STATISTICS';
const String MATCH_STATISTICS_SOCIALS = 'MATCH_STATISTICS_SOCIALS';
const String MATCH_STATISTICS = 'MATCH_STATISTICS';
const String SEASON_STATISTICS_SOCIALS = 'SEASON_STATISTICS_SOCIALS';
const String SEASON_STATISTICS = 'SEASON_STATISTICS';
const String SOCIALS_KW = 'SOCIALS';
const String AGGIUNGI_GIOCATORE = 'Aggiungi giocatore';
//endregion

//region file
const String PNG = '.png';
const String CSV = '.csv';
const String BAT = '.bat';
const String MKV = '.mkv';
const String TXT = '.txt';
const String MP4 = '.mp4';
const String JSON = '.json';
const String PSD = '.psd';
const List<String> VIDEO_TYPE_PICKER = [MKV, MP4];
const String GIALLI_CSV = '_formazioneGialli.csv';
const String VERDI_CSV = '_formazioneVerdi.csv';
const String PITCH_GIALLO_PSD = r'Photoshop\pitch\pitch_giallo_';
const String PITCH_VERDE_PSD = r'Photoshop\pitch\pitch_verde_';
const String ROOKIE_GIALLO_PSD = r'Photoshop\cards\rookie_giallo.psd';
const String ROOKIE_VERDE_PSD = r'Photoshop\cards\rookie_verde.psd';
const String FORMAZIONE_GIALLI_AHK = r'newPartita\formazioni\formazioneGialli.txt';
const String FORMAZIONE_VERDI_AHK = r'newPartita\formazioni\formazioneVerdi.txt';
const String CARTE_GIALLE_CSV = 'carteGialleMancanti.csv';
const String CARTE_VERDI_CSV = 'carteVerdiMancanti.csv';
const String CURRENT_FOLDER = 'current';
const String FORMAZIONE_GIALLI_IMG = 'formazioneGialli.png';
const String FORMAZIONE_VERDI_IMG = 'formazioneVerdi.png';
//endregion

//region messages
const String Y_LINEUP_HEADER = '🟡🟡🟡 GIALLI ⚫⚫⚫\n';
const String G_LINEUP_HEADER = '\n\n🟢🟢🟢 VERDI ⚪⚪⚪\n';
const String SQUAD_CONFERMATI_HEADER = '🟡🟡🟡 SQUAD 🟢🟢🟢\n';
const String ROOKIE_CONFERMATI_HEADER = '🃏🃏🃏 EXTRA 🃏🃏🃏\n';
const String TWITCH_CHANNEL_LINK = 'https://www.twitch.tv/fakefootballtv';

const String LOAD_CONTENTS_MSG = 'Caricamento contenuti in corso...';
const String RIEPILOGO_PARTITA = 'RIEPILOGO PARTITA';
const String RIEPILOGO_STAGIONE = 'RIEPILOGO STAGIONE';
//endregion

//region firebase fields
const String ASSIST = 'assist';
const String ASSIST_MATCH = 'assistMatch';
const String GOAL = 'goal';
const String GOAL_MATCH = 'goalMatch';
const String QUASI_GOAL = 'quasiGoal';
const String QUASI_GOAL_MATCH = 'quasiGoalMatch';
const String NAME = 'name';
const String NUMBER = 'number';
const String APPEARANCES = 'appearances';
const String ROLE = 'ruoli';
const String CONTENT_DONE = 'contentDone';
const String OFFICIAL_MATCH_FB = 'officialMatch';
const String MVP = 'mvp';
const String VIOLENZA_SUBITA = 'violenzaSubita';
const String VIOLENZA_FATTA = 'violenzaFatta';
const String MANDATI_AL_BARETTO = 'mandatiAlBaretto';
const String ANDATO_AL_BARETTO = 'andatoAlBaretto';
const String PAPERE_COMMESSE = 'papereCommesse';
const String VIOLENZA_SUBITA_MATCH = 'violenzaSubitaMatch';
const String VIOLENZA_FATTA_MATCH = 'violenzaFattaMatch';
const String MANDATI_AL_BARETTO_MATCH = 'mandatiAlBarettoMatch';
const String ANDATO_AL_BARETTO_MATCH = 'andatoAlBarettoMatch';
const String PAPERE_COMMESSE_MATCH = 'papereCommesseMatch';
const String RIGORI_TIRATI_MATCH = 'rigoriTiratiMatch';
const String RIGORI_SEGNATI_MATCH = 'rigoriSegnatiMatch';
const String RIGORI_TIRATI = 'rigoriTirati';
const String RIGORI_SEGNATI = 'rigoriSegnati';
//endregion

//region http
const String BASE_URL =
    'https://fakefootball-721c3-default-rtdb.europe-west1.firebasedatabase.app/';
const String FIXED_PARAMS = '.json?auth=kxGkE0uneKvsb2K6XLAzaVFZL80dPVMFvt62HZKv';
const String FIXED_PARAMS_JSON = '.json';
final http.Response DEFAULT_TIMEOUT_RESPONSE =
    http.Response("", 500, reasonPhrase: "TIMEOUT ERROR");
const Duration TIMOUT_AMOUNT = Duration(seconds: 8);
const String TWITCH_CHAT_EMBED_URL =
    'https://www.twitch.tv/embed/fakefootballtv/chat?darkpopout&parent=localhost';
//endregion

//region roles
const String POR = 'por';
const String CC = 'cc';
const String DC = 'dc';
const String ATT = 'att';
const String ALA = 'ala';
const List<String> ROLES = ['', POR, DC, CC, ALA, ATT];
const List<String> ORDERED_FIELDS_ZONE = [DC, CC, ATT];
const String SELEZIONA_MODULO = 'Seleziona modulo';
//endregion

//region firebase nodes
const String CURRENT_GAME = 'currentGame';
const String PAST_GAMES = 'pastGames';
const String MATCH = 'match';
const String MODULI = 'moduli';
const String MODULI_PREFIX = 'calcio_';
const String MATCH_TYPE = 'matchType';
const String SQUAD_MODULE = 'squadModule';
const String JERSEY_COLOR = 'jerseyColor';
const String MODULO_GIALLI = 'moduloGialli';
const String MODULO_VERDI = 'moduloVerdi';
const String CONVOCATI = 'convocati';
const String GIALLI = 'GIALLI';
const String SQUAD = 'SQUAD';
const String VERDI = 'VERDI';
const String PLAYERS = 'players';
const String ROOKIES = 'rookies';
const String CURRENT_INDEX = 'currentIndex';
//endregion
//region numbers
const int YELLOW_KEEPER = 1;
const int GREEN_KEEPER = 12;
const List<int> YELLOW_ROOKIES = [69, 74, 44];
const List<int> GREEN_ROOKIES = [20, 33, 90];
const String NON_CONVOCATO = 'Non convocato';
const List<String> YELLOW_ROOKIES_SPINNER = [NON_CONVOCATO, "69", "74", "44"];
const List<String> GREEN_ROOKIES_SPINNER = [NON_CONVOCATO, "20", "33", "90"];

//endregion

//region generics
const String NON_C_E_PORTIERE = 'NON_C_E_PORTIEREEE';
const String NON_C_E_ROCKIE = 'NON_C_E_ROCKIEEEEE';
const String CHECK_EMOJ = '✔️';
const String ERROR_EMOJ = '❌';
//end region

//region home
const String CONVOCA_GIOCATORI = 'Convoca giocatori';
const String CONFERMA_CONVOCATI = 'Conferma convocati';
const String ALL_DONE = 'allDone';
const String GAME_TRACKER = 'Game tracker';
const String OFFICIAL_MATCH = 'Official match';
const String MATCH_RESUME = 'Match resume';
const String VIDEO_GENERATOR = 'Video generator';
const String ROASTER = 'Roaster';
const String CONVOCA_P = 'Convoca giocatori';
const String GEN_OBS = 'Genera formazioni e carte';
const String GEN_SOCIALS = 'Genera formazioni socials';
const String REDO_P = 'Rifai formazioni';
//end region

//region csv
const List<String> CARD_HEADER = [FILE_NAME, NAME, NUMBER];

const List<String> LINE_UP_HEADER_1_4_1 = [
  FILE_NAME,
  POR,
  DC_1_4_1,
  ES_1_4_1,
  CDC1_1_4_1,
  CDC2_1_4_1,
  ED_1_4_1,
  ATT_1_4_1,
];

const List<String> LINE_UP_HEADER_2_3_1 = [
  FILE_NAME,
  POR,
  DC1_2_3_1,
  DC2_2_3_1,
  ES_2_3_1,
  CC_2_3_1,
  ED_2_3_1,
  ATT_2_3_1
];

const List<String> LINE_UP_HEADER_3_2_1 = [
  FILE_NAME,
  POR,
  ASA_3_2_1,
  DC_3_2_1,
  ADA_3_2_1,
  CC1_3_2_1,
  CC2_3_2_1,
  ATT_3_2_1,
];

const List<String> LINE_UP_HEADER_3_2_1_2 = [
  FILE_NAME,
  POR,
  DC1_3_2_1_2,
  DC2_3_2_1_2,
  DC3_3_2_1_2,
  ES_3_2_1_2,
  ED_3_2_1_2,
  AT_3_2_1_2
];

//region 1-4-1
const String PLAYER_1_4_1 = 'player141';
const String DC_1_4_1 = 'dc141';
const String CDC1_1_4_1 = 'cdc1_141';
const String CDC2_1_4_1 = 'cdc2_141';
const String ED_1_4_1 = 'ed141';
const String ES_1_4_1 = 'es141';
const String ATT_1_4_1 = 'att141';
//endregion

//region 3-2-1
const String PLAYER_3_2_1 = 'player321';
const String DC_3_2_1 = 'dc321';
const String ASA_3_2_1 = 'asa321';
const String ADA_3_2_1 = 'ada321';
const String CC1_3_2_1 = 'cc1_321';
const String CC2_3_2_1 = 'cc2_321';
const String ATT_3_2_1 = 'att321';
//endregion

//region 2-3-1
const String PLAYER_2_3_1 = 'player231';
const String DC1_2_3_1 = 'dc1_231';
const String DC2_2_3_1 = 'dc2_231';
const String CC_2_3_1 = 'cc231';
const String ED_2_3_1 = 'ed231';
const String ES_2_3_1 = 'es231';
const String ATT_2_3_1 = 'att231';
//endregion

const String PLAYER_3_2_1_2 = 'player3212';
const String DC1_3_2_1_2 = 'dc1_3212';
const String DC2_3_2_1_2 = 'dc2_3212';
const String DC3_3_2_1_2 = 'dc3_3212';
const String ED_3_2_1_2 = 'ed3212';
const String ES_3_2_1_2 = 'es3212';
const String AT_3_2_1_2 = 'at3212';

const String FILE_NAME = 'fileName';
//endregion

//region lineup
const String SECOND_VERSION = '(2)';
//endregion
//region settings
const String ROASTER_DIR = 'FakeFootball roaster';
const String SQUAD_DIR = 'squad';
const String ROOKIES_DIR = 'rookies';
const String FOLDER_NEW_PARTITA = 'newPartita';
const String FOLDER_CARTE_MANCANTI = 'Carte mancanti';
const String FOLDER_GK = 'portieri';
const String FOLDER_FORMAZIONI = 'formazioni';
const String FOLDER_PARTITA = 'partita';
const String COPIA_PH_REMOVE = ' copia';
const String PLACEHOLDER_2T = 'mimmo_secondo';
const String ROOT_DIR_NO_SLASH = 'FakeFootball';
const String TRACKING_DB_DIR = 'trackingDb';
const String VIDEO = 'Video';

const String VIDEO_READER_PATH = 'Lettore video:';
const String ROOT_PATH = 'Work directory:';
const String PS_PATH = 'Percorso Photoshop:';
const String PLACEHOLDER_PRIMO_TEMPO = 'Video capitolo primo tempo:';
const String PLACEHOLDER_SECONDO_TEMPO = 'Video capitolo secondo tempo:';
const String PLACEHOLDER_FFMOMENTS = 'Video capitolo fake moments:';
const String MAX_ROLE_PER_PLAYER = 'MAX_ROLE_PER_PLAYER';

const String F_TYPE_VID = 'VIDEO';
const String F_TYPE_IMG = 'IMG';
const String F_TYPE_DIR = 'DIR';
const String F_TYPE_EXE = 'EXE';
//endregion

//region events description
const String GOAL_EVENT = 'GOAL';
const String QUASI_GOAL_EVENT = 'QUASI_GOAL';
const String PAPERA_EVENT = 'PAPERA';
const String RIGORE_EVENT = 'RIGORE';
const String SKILLS_EVENT = 'SKILLS';
const String LOL_REGIA_EVENT = 'LOL_REGIA';
const String VIOLENZA_EVENT = 'VIOLENZA';
const String AL_BARETTO_EVENT = 'AL_BARETTO';
const String BANNER_EVENT = 'BANNER';
const String CALCIO_5 = 'Calcio a 5';
const String CALCIO_7 = 'Calcio a 7';
const String EXPORT_DB = 'Export db tracking';
const String SETTINGS = 'Settings';
const String INIZIO_PARTITA = 'INIZIO PARTITA';
const String FINE_PRIMO_TEMPO = 'FINE PRIMO TEMPO';
const String INIZIO_SECONDO_TEMPO = 'INIZIO SECONDO TEMPO';
const String FINE_PARTITA = 'FINE PARTITA';
const String FAVOURITE = 'AZIONI PREFERITE';
const String SBAGLIATO = '_sbagliato';
const String SEGNATO = '_segnato';

//endregion

//region video generator
const String HIGHLIGHTS = 'HIGHLIGHTS';
const String PAPERE = 'PAPERE';
const String AL_BARETTO = 'AL BARETTO';
const String VIOLENZA = 'VIOLENZA';
const String FUNNY_MOMENTS_REGIA = 'REGIA FUNNY MOMENTS';
const String AGGIUNGI_AZIONE = 'AGGIUNGI AZIONE';
const String START = 'START';
const String END = 'END';
//endregion

//region build conten
const int TAB_MODULO = 0;
const int TAB_ROOKIES = 1;
const int TAB_FORMAZIONI = 1;
const int TAB_FORMAZIONI_WITH_ROOKIES = 2;
//endregion

//region moduli
const String M_1_4_1 = '1-4-1';
const String M_2_3_1 = '2-3-1';
const String M_3_2_1 = '3-2-1';
const String M_3_2_1_2 = '3-2-1(2)';
//endregion

//region permissions
List<Permission> STORAGE_PERMISSIONS = [
  Permission.storage,
  Permission.manageExternalStorage,
  Permission.mediaLibrary,
];

List<Permission> STORAGE_33_PERMISIONS = [
  Permission.videos,
  Permission.photos,
  Permission.audio,
];
//endregion

//region export
const String SPORT_MATCHES_JSON = 'sportMatches.json';
const String EVENTS_JSON = 'events.json';
//endregion

//region time
const String EPOCH_DATE = '1970-01-01';
const String TIMER_FORMAT = 'HH:mm:ss';
const Duration MINUTE_1 = Duration(minutes: 1);

//endregion

//region regex
const String IS_FILE = r'^([a-zA-Z]:[\\\/]|\\\\|[\\/])([^\\\/:*?"<>|]+[\\\/])*[^\\\/:*?"<>|]*$';
//endrewgion

//region cmd
const String TASKKILL = 'taskkil';
const String PID = '/PID';
//endregion

//region dateformat
const String OBS_RECORDING_NAME = 'yyyy-MM-dd HH-mm';
const String MATCH_DATE = 'yyyy-MM-dd';
//endregion

const List<Shadow> BLACK_STROKE = [
  Shadow(
    offset: Offset(-1.5, -1.5),
    color: Colors.black,
  ),
  Shadow(
    offset: Offset(1.5, -1.5),
    color: Colors.black,
  ),
  Shadow(
    offset: Offset(1.5, 1.5),
    color: Colors.black,
  ),
  Shadow(
    offset: Offset(-1.5, 1.5),
    color: Colors.black,
  ),
];
