# DongZaiProject
## 一个根据心情推送最适合当下音乐的音乐播放器
##123123
智能情景音乐推荐APP - 项目描述
 
一、项目概述
 
本项目是一款适配vivo手机的跨平台智能音乐应用，以「情景感知+个性化推荐」为核心，整合本地音乐播放与多维度用户数据（生理、环境、偏好），通过AI大模型生成精准歌曲推荐。核心价值在于打破传统音乐播放器的被动播放模式，基于用户实时心率、位置天气、网易云音乐偏好及个人属性（年龄/MBTI），动态推荐本地未存储的歌曲，实现“千人千面、即时适配”的音乐体验。
 
| 模块                | 技术选型                                  | 核心作用                                  |
|---------------------|-------------------------------------------|-------------------------------------------|
| 前端框架            | Flutter（Dart）                           | 跨平台UI开发，适配vivo Android系统        |
| 本地音乐播放        | Flutter插件：`just_audio`+`audio_service`  | 播放控制、后台播放、锁屏交互              |
| 本地音乐扫描        | Flutter插件：`media_store`+`permission_handler` | 访问系统媒体库、申请存储权限              |
| 后端服务            | Python + FastAPI                          | 接口转发、数据整合、AI调用、第三方API对接  |
| vivo健康数据对接    | Flutter `platform_channels` + Android原生  | 桥接vivo Health Kit SDK获取心率           |
| 位置/天气数据       | Flutter `geolocator` + 和风天气API        | 获取经纬度、调用天气接口                  |
| 网易云数据获取      | 第三方API：Binaryify/NeteaseCloudMusicApi + pyncm | 获取用户收藏歌单，规避官方权限限制        |
| 数据存储            | 前端：`hive`（本地缓存）；后端：`SQLite`  | 存储用户信息、本地歌曲列表、推荐记录      |
| AI推荐引擎          | GPT-4o Mini / 通义千问API                 | 多维度数据解析、歌曲推荐生成              |
| 部署平台            | 后端：Railway/PythonAnywhere（免费）；前端：APK打包 | 后端公网部署、前端vivo手机安装            |


二、核心功能
 
1. 本地音乐核心功能
 
- 高效扫描vivo手机本地音频文件（支持.mp3/.flac/.wav等格式），提取歌曲名、歌手、专辑、时长等元数据
- 流畅播放控制（播放/暂停/切歌、进度调节、后台播放、锁屏控制）
- 本地歌曲列表管理（按歌手/专辑分类、搜索、收藏）
 
2. 多维度数据采集
 
- 生理数据：通过vivo Health Kit获取用户实时心率（Flutter+Android原生桥接实现）
- 环境数据：获取手机位置（经纬度），对接和风天气API获取实时天气（温度、天气状况）
- 偏好数据：通过第三方网易云API获取用户收藏歌单（规避官方个人开发者限制）
- 个人属性：首次启动问卷收集用户年龄、MBTI人格类型
 
3. 智能推荐模块
 
- 数据整合：将心率、位置、天气、网易云歌单、年龄、MBTI打包为AI输入特征
- AI推断：调用GPT-4o Mini/通义千问API，分析用户当前情景（心情+场景）
- 精准推荐：返回5首本地未存储的歌曲（格式：歌名-歌手），风格匹配情景与偏好
- 去重逻辑：推荐前对比本地歌曲列表，确保无重复推荐
 
4. 首次启动引导
 
- 步骤式引导流程：网易云账号登录 → 年龄输入 → MBTI精简测试（10题）→ 权限申请（存储/位置/健康数据）
- 数据缓存：用户信息、偏好数据本地存储，后续启动无需重复输入
 
三、技术栈选型
 
模块 技术选型 核心作用 
前端框架 Flutter（Dart） 跨平台UI开发，适配vivo Android系统 
本地音乐播放 Flutter插件： just_audio + audio_service  播放控制、后台播放、锁屏交互 
本地音乐扫描 Flutter插件： media_store + permission_handler  访问系统媒体库、申请存储权限 
后端服务 Python + FastAPI 接口转发、数据整合、AI调用、第三方API对接 
vivo健康数据对接 Flutter  platform_channels  + Android原生 桥接vivo Health Kit SDK获取心率 
位置/天气数据 Flutter  geolocator  + 和风天气API 获取经纬度、调用天气接口 
网易云数据获取 第三方API：Binaryify/NeteaseCloudMusicApi + pyncm 获取用户收藏歌单，规避官方权限限制 
数据存储 前端： hive （本地缓存）；后端： SQLite  存储用户信息、本地歌曲列表、推荐记录 
AI推荐引擎 GPT-4o Mini / 通义千问API 多维度数据解析、歌曲推荐生成 
部署平台 后端：Railway/PythonAnywhere（免费）；前端：APK打包 后端公网部署、前端vivo手机安装 
 
四、模块详细设计
 
1. 前端（Flutter）核心模块
 
（1）本地音乐扫描与播放
 
dart  
// 核心逻辑示例：本地音乐扫描
Future<List<LocalSong>> scanLocalSongs() async {
  List<LocalSong> songs = [];
  // 申请Android 13+音频权限
  if (await Permission.audio.request().isGranted) {
    final audioFiles = await MediaStore().getAudioFiles(
      columns: [MediaStoreColumns.title, MediaStoreColumns.artist, MediaStoreColumns.data],
    );
    songs = audioFiles.map((file) => LocalSong(
      title: file.title ?? "未知歌曲",
      artist: file.artist ?? "未知歌手",
      path: file.data!,
    )).toList();
  }
  return songs;
}
 
 
（2）vivo心率数据获取（原生桥接）
 
- Flutter端：通过 MethodChannel 发起原生调用
- Android原生端：集成vivo Health Kit SDK，获取心率数据并返回Flutter
 
（3）用户信息收集界面
 
- 采用步骤式表单，结合 Provider 管理全局状态，数据实时缓存至 hive 
 
2. 后端（Python+FastAPI）核心模块
 
（1）接口设计
 
-  /api/user/info ：接收前端用户信息（年龄/MBTI/网易云UID），存储至数据库
-  /api/data/integrate ：接收心率、位置、本地歌曲列表，整合天气+网易云歌单数据
-  /api/recommend ：调用AI大模型，返回5首去重后的推荐歌曲
 
（2）网易云歌单获取（第三方API）
 
python  
def get_netease_collections(uid: str) -> list:
  """通过Binaryify API获取用户收藏歌单"""
  url = f"https://neteasecloudmusicapi.vercel.app/user/playlist?uid={uid}"
  response = requests.get(url).json()
  return [{"name": p["name"], "tracks": p["tracks"][:10]} for p in response["playlist"] if p["subscribed"]]
 
 
（3）AI推荐逻辑
 
python  
def generate_recommendation(all_data: dict) -> list:
  """整合数据调用AI生成推荐"""
  local_songs = "\n".join([f"{s['title']}-{s['artist']}" for s in all_data["local_songs"]])
  prompt = f"""基于以下信息推荐5首本地没有的歌曲，仅返回「歌名-歌手」格式：
  心率：{all_data['heart_rate']}，天气：{all_data['weather']}，年龄：{all_data['age']}，MBTI：{all_data['mbti']}
  网易云收藏歌单：{all_data['netease_playlists'][:2]}
  本地已存歌曲：{local_songs}
  要求：风格匹配当前情景（心率→心情，天气→场景），贴合用户偏好"""
  
  response = openai.ChatCompletion.create(
    model="gpt-4o-mini",
    messages=[{"role": "user", "content": prompt}]
  )
  return [{"title": s.split("-")[0], "artist": s.split("-")[1]} for s in response.choices[0].message.content.split("\n") if "-" in s]
 
 
五、关键难点与解决方案
 
核心难点 解决方案 
vivo健康数据（心率）获取（Flutter无官方插件） 采用 platform_channels 桥接Android原生代码，集成vivo Health Kit SDK 
网易云官方API无个人申请通道 使用Binaryify/NeteaseCloudMusicApi+pyncm第三方方案，支持用户歌单获取 
本地音乐扫描卡顿（大量文件场景） 多线程扫描+增量更新+缓存优化，仅扫描音频格式文件 
AI推荐与本地歌曲去重 前端传递本地歌曲列表至后端，AI提示词明确排除已存歌曲 
跨平台适配（仅聚焦vivo Android） 针对性处理vivo权限申请流程、Health Kit适配，简化iOS兼容成本 
 
六、实施路径（6个月）
 
阶段 时长 核心任务 
基础搭建 1.5个月 Flutter前端：界面搭建+本地音乐扫描/播放；FastAPI后端：基础接口开发 
数据采集 2个月 对接vivo Health Kit获取心率；集成位置/天气API；实现网易云歌单获取；开发用户信息问卷 
推荐系统 1.5个月 前后端联调；AI大模型对接；推荐逻辑实现（数据整合+去重） 
优化部署 1个月 性能优化（扫描/加载速度）；异常处理；后端部署；APK打包测试 
 
七、预期成果
 
1. 可运行的vivo手机APK安装包，支持本地音乐播放与智能推荐核心功能
2. 完整的前后端项目代码（Flutter前端+Python后端），结构清晰可复用
3. 实现“生理数据+环境+偏好”多维度驱动的个性化推荐，推荐准确率≥80%
4. 无强制付费功能，纯学习型项目，可扩展支持更多品牌手机与音乐平台
 
| 核心难点                                  | 解决方案                                  |
|-------------------------------------------|-------------------------------------------|
| vivo健康数据（心率）获取（Flutter无官方插件） | 采用`platform_channels`桥接Android原生代码，集成vivo Health Kit SDK |
| 网易云官方API无个人申请通道                | 使用Binaryify/NeteaseCloudMusicApi+pyncm第三方方案，支持用户歌单获取 |
| 本地音乐扫描卡顿（大量文件场景）           | 多线程扫描+增量更新+缓存优化，仅扫描音频格式文件 |
| AI推荐与本地歌曲去重                      | 前端传递本地歌曲列表至后端，AI提示词明确排除已存歌曲 |
| 跨平台适配（仅聚焦vivo Android）          | 针对性处理vivo权限申请流程、Health Kit适配，简化iOS兼容成本 |

备注
 
- 项目聚焦学习与实战，不涉及商业用途，所有第三方API使用遵循开源协议与平台规范
- 核心亮点：适配vivo生态、多维度数据融合、AI大模型落地、避开官方API限制，适合作为软件工程专业学生的实战作品集项目