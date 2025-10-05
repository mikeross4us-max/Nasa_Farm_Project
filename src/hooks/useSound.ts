import { useRef, useEffect, useState } from 'react';

export function useSound(url: string, volume = 0.5) {
  const audioRef = useRef<HTMLAudioElement | null>(null);

  useEffect(() => {
    if (!audioRef.current) {
      audioRef.current = new Audio(url);
      audioRef.current.volume = volume;
    }
    return () => {
      if (audioRef.current) {
        audioRef.current.pause();
        audioRef.current = null;
      }
    };
  }, []);

  const play = () => {
    if (audioRef.current) {
      audioRef.current.currentTime = 0;
      audioRef.current.play().catch(console.error);
    }
  };

  return { play };
}

export function useBackgroundMusic(enabled = true) {
  const audioRef = useRef<HTMLAudioElement | null>(null);
  const [hasStarted, setHasStarted] = useState(false);

  useEffect(() => {
    if (enabled && !hasStarted) {
      const initAudio = () => {
        if (!audioRef.current) {
          audioRef.current = new Audio('https://assets.mixkit.co/active_storage/sfx/2571/2571-preview.mp3');
          audioRef.current.loop = true;
          audioRef.current.volume = 0.15;
          audioRef.current.play().catch(console.error);
          setHasStarted(true);
        }
        document.removeEventListener('click', initAudio);
      };

      document.addEventListener('click', initAudio);

      return () => {
        document.removeEventListener('click', initAudio);
      };
    }
  }, [enabled, hasStarted]);

  useEffect(() => {
    return () => {
      if (audioRef.current) {
        audioRef.current.pause();
        audioRef.current = null;
      }
    };
  }, []);

  return audioRef;
}
