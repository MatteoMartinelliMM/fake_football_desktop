// ignore_for_file: constant_identifier_names

const String ACODEC = 'ACODEC';
const String AR = 'AR';
const String ASPECT_RATIO = 'ASPECT_RATIO';
const String BITRATE = 'BITRATE';
const String CHANNELS = 'CHANNELS';
const String COPY = 'copy';
const String CROP = 'CROP';
const String DURATION = 'DURATION';
const String ENCODER = 'ENCODER';
const String FILTER_COMPLEX = 'FILTER_COMPLEX';
const String FORMAT = 'FORMAT';
const String FPS = 'FPS';
const String HEIGHT = 'HEIGHT';
const String LOG_LEVEL = 'LOG_LEVEL';
const String MAP = 'map';
const String MAXRATE = 'MAXRATE';
const String MOVFLAGS = 'MOVFLAGS';
const String OFFSET = 'OFFSET';
const String OUTPUT = 'OUTPUT';
const String OVERWRITE_OUTPUT = 'OVERWRITE_OUTPUT';
const String PIXEL_FORMAT = 'PIXEL_FORMAT';
const String PROFILE = 'PROFILE';
const String QUALITY = 'QUALITY';
const String RESOLUTION = 'RESOLUTION';
const String SAMPLE_RATE = 'SAMPLE_RATE';
const String SEEK = 'SEEK';
const String SS = 'ss';
const String TO = 'to';
const String VCODEC = 'VCODEC';
const String VIDEO_FILTER = 'VIDEO_FILTER';
const String WIDTH = 'WIDTH';



const String FFMPEG = 'ffmpeg';
const String FFPROBE = 'ffprobe ';
const String OVERWRITE_Y = 'y';
const String F = 'f';
const String INPUT_VIDEO = 'i';
const String INPUT = 'i';
const String C = 'c';
const String VERBOSE ='v';
const String QUIET = 'quiet';
const String PRINT_FORMAT = 'print_format';
const String JSON_K_W = 'json';
const String FILE_K_W = 'file';
const String CONCAT = 'concat';
const String SAFE = 'safe';
const String CODEC = 'codec';
const String SHOW_STREAMS = 'show_streams';

const String VF = 'vf';
const String SYNC_FRAME_RATE = '$VF "setpts=PTS/FRAME_RATE"';
const String AF = 'af';
const String SYNC_AUDIO = '$AF "aresample=async=1"';
const String FALSE_FFM= '0';
const String CODEC_LIB_X264 = '$C:v libx264';
const String PRESET= 'preset';
const String MEDIUM = 'medium';
const String SLOW = 'slow';
const String CRF = 'crf'; //constant rate factor
const String AUDIO_CODEC_AAC = '$C:a aac';
const String AAC_CODEC = 'c:a aac';
const String AUDIO_BIT_RATE_192_k = 'b:a 192k';
const String VIDEO_BIT_RATE= 'b:v 5000k';
const String FRAME_RATE = 'r';
const String FPS_30 = '30';
const String FPS_60 = '60';
const String VSYNC_VFR = 'vsync vfr';
const String FILTER_30_FPS = 'filter:v "fps=30"';
const String DEFAULT_VIDEO_ENCODING = '-$CODEC_LIB_X264 -$PRESET $MEDIUM -$CRF 23 -$VIDEO_BIT_RATE -$AAC_CODEC -$AUDIO_BIT_RATE_192_k';
const String RESET_TS = '-reset_timestamps 1 -avoid_negative_ts 1';

const String SHOW_FORMAT = 'show_format';
const String ANALYZE_DURATION = 'analyzeduration';
const String PROBE_SIZE = 'probesize';
const String SECONDS_45 = '45M';
const String MB_150 = '150M';
//-c:v libx264 -preset medium -crf 23 -b:v 5000k -c:a aac -b:a 192k

//ffmpeg -y -i "F:\Users\Teo\Documents\FakeFootball\editing\placeholders\primo_tempo.mp4" -c:v libx264 -preset medium -crf 23 -b:v 5000k -c:a aac -b:a 192k -vf "scale=1280:720" "F:\Users\Teo\Documents\FakeFootball\editing\placeholders\mimmo_primo.mp4"

//ffmpeg -y -i "F:\Users\Teo\Documents\FakeFootball\editing\placeholders\secondo_tempo.mp4" -c:v libx264 -preset medium -crf 23 -b:v 5000k -c:a aac -b:a 192k -vf "scale=1280:720" "F:\Users\Teo\Documents\FakeFootball\editing\placeholders\mimmo_secondo.mp4"