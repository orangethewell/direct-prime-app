import React from 'react';
import { Pressable, Text, Platform } from 'react-native';

export function DPButton({ onPress, title, className, textClassName }) {
  return (
    <Pressable
      onPress={onPress}
      // No Android, ativa o ripple nativo:
      android_ripple={{ color: 'rgba(255,255,255,0.3)' }}
      // No iOS, faz um "fade" de opacidade como fallback:
      style={({ pressed }) => [
        // aplica opacidade no iOS/Android caso queira
        Platform.OS === 'ios' && pressed && { opacity: 0.6 },
      ]}
      className={className ? className : "bg-blue-600 rounded-lg px-4 py-2" }
    >
      <Text className={textClassName ? textClassName : "text-white text-center font-medium" }>
        {title}
      </Text>
    </Pressable>
  );
}
