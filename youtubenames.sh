#!/bin/bash

# Array of YouTube video links
youtube_links=(
"https://youtu.be/NwK7WdjOeAc"
"https://youtu.be/ShtCh2fSJHI"
"https://youtu.be/JFV1AzKcZT4"
"https://youtu.be/RMEU8UxL62A"
"https://youtu.be/xHX0ZsgEsxE"
"https://youtu.be/FfdLzyhwqSE"
"https://youtu.be/_AOzpFXocKI"
"https://youtu.be/COqwWxd32Ho"
"https://youtu.be/rSLeQdK-k5o"
"https://youtu.be/4oQwRLT_eUM"
"https://youtu.be/HDia14RTlW4"
"https://youtu.be/QPHmNQr4njI"
"https://youtu.be/H9yhnMIpRS8"
"https://youtube.com/shorts/gxyN0yZwr1k"
"https://youtube.com/shorts/9nDZiAcZ0os"
"https://youtube.com/shorts/qpyCZk7HNbU"
"https://youtube.com/shorts/cWk7UpC4qHc"
"https://youtube.com/shorts/Ms46NYWgJCg"
"https://youtube.com/shorts/mbGSTT7Ux5w"
"https://youtube.com/shorts/IBgBg8Bb-1U"
"https://youtube.com/shorts/tP3-Jajt4lE"
"https://youtube.com/shorts/7vNdFNFbbco"
"https://youtube.com/shorts/9X1Va9vtkAI"
"https://youtube.com/shorts/oQwSreTQ-Pg"
"https://youtube.com/shorts/rvGbCN1vPUM"
"https://youtube.com/shorts/dhfX1iQ6Ca4"
"https://youtube.com/shorts/yftkMlHw2xY"
"https://youtube.com/shorts/aSGoS9UTG2k"
"https://youtube.com/shorts/VKw1zjZRk-A"
"https://youtube.com/shorts/9X_zs4D3f4Y"
"https://youtube.com/shorts/DZ2tsntfoIw"
"https://youtube.com/shorts/hoeyVbobsEc"
"https://youtube.com/shorts/XKzMp93soTI"
"https://youtube.com/shorts/sLN76eQmgVw"
"https://youtube.com/shorts/vivOIM7XEE4"
"https://youtube.com/shorts/QspMqIKmNWY"
"https://youtube.com/shorts/RqJt7waRp7A"
"https://youtube.com/shorts/scMxMH8yXBk"
"https://youtube.com/shorts/KDE_EQxgjog"
"https://youtube.com/shorts/6qJqE5y8_Cc"
"https://youtube.com/shorts/PaxHtJ1V5as"
"https://youtube.com/shorts/CtCiC4a8dTQ"
"https://youtube.com/shorts/UA9HGKgLWsU"
"https://youtube.com/shorts/6e2Jqr66Jq4"
"https://youtube.com/shorts/O52HNleBH4w"
"https://youtube.com/shorts/HJcyR4w-U9E"
"https://youtube.com/shorts/4nMNXwcBbYE"
"https://youtube.com/shorts/zsbY12a5T6U"
"https://youtube.com/shorts/AT89ZRhxtl8"
"https://youtube.com/shorts/4ukm36vkwlE"
)

# Loop through each YouTube link and extract the video title
for link in "${youtube_links[@]}"; do
    # Use yt-dlp to get the video title
    video_title=$(yt-dlp --get-title "$link")
    
    # Print the video title
    echo "Video Title: $video_title"
done
