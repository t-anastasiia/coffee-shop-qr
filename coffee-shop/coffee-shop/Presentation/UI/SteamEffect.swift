//
//  SteamEffect.swift
//  coffee-shop
//
//  Created by anastasiia talmazan on 2025-02-10.
//

import SwiftUI

struct SteamParticle: Identifiable {
    let id = UUID()
    var position: CGPoint
    var scale: CGFloat
    var opacity: Double
}

struct SteamEffect: View {
    @State private var particles: [SteamParticle] = []
    @State private var timer: Timer?
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(particles) { particle in
                Circle()
                    .fill(.white.opacity(0.5))
                    .frame(width: 10, height: 10)
                    .scaleEffect(particle.scale)
                    .opacity(particle.opacity)
                    .position(particle.position)
            }
        }
        .onAppear {
            startSteamAnimation()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private func startSteamAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            createParticle()
            removeOldParticles()
        }
    }
    
    private func createParticle() {
        let randomX = CGFloat.random(in: -20...20)
        let particle = SteamParticle(
            position: CGPoint(x: 50 + randomX, y: 0),
            scale: CGFloat.random(in: 0.5...1.5),
            opacity: 1.0
        )
        
        particles.append(particle)
        
        withAnimation(.easeOut(duration: 2.0)) {
            if let index = particles.firstIndex(where: { $0.id == particle.id }) {
                particles[index].position.y -= CGFloat.random(in: 100...200)
                particles[index].scale *= 2
                particles[index].opacity = 0
            }
        }
    }
    
    private func removeOldParticles() {
        particles.removeAll { $0.opacity <= 0 }
    }
}
