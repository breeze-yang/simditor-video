# Simditor Video

Simditor 的插入视频扩展，为工具栏添加一个 video 按钮，用于插入 video 标签。

![Demo Gif](https://raw.githubusercontent.com/breeze-yang/simditor-video/master/simditor-video-demo.gif)

## 如何使用

在 Simditor 的基础上额外引入 simditor-video 的脚本和样式

````
<link rel="stylesheet" type="text/css" href="/path/to/simditor-video.css" />
<script src="/path/to/simditor-video.js"></script>
````

在初始化 simditor 的时候，在 `toolbar` 选项中加入 `video` 即可，如：

````
var simditor = new Simditor({
  textarea: '#textarea',
  toolbar: ['video', 'strikethrough', 'ol', 'ul']
});

````
