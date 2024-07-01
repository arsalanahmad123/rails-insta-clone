document.addEventListener("turbo:load", () => {
    const videoElements = document.querySelectorAll('[data-trial-id]');
    videoElements.forEach((element) => {
        const video = element.querySelector('video');
        const volumeBtn = element.querySelector('[data-action="toggleVolume"]');
        const playBtn = element.querySelector('[data-action="toggleVideo"]');
        // Automatically mute the video on play

        video.addEventListener("click", () => {
            if (video.paused) {
                video.play();
                playBtn.classList.add("hidden");
            }
            else {
                video.pause();
                playBtn.classList.remove("hidden");
            }
        })


        // Toggle play/pause on playBtn click
        playBtn.addEventListener("click", () => {
            if (video.paused) {
                video.play();
                playBtn.classList.add("hidden");
            } else {
                video.pause();
                playBtn.classList.remove("hidden");
            }
        });
        // Toggle volume on volumeBtn click
        volumeBtn.addEventListener("click", () => {
            if (video.muted) {
                video.muted = false;
                volumeBtn.children[0].innerHTML = "volume_up";
            } else {
                video.muted = true;
                volumeBtn.children[0].innerHTML = "volume_off";
            }
        });
    });
});