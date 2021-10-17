export default function calculateStatInternal(min: number, max: number, maxEffect: number, level: number, stat: number): number {
    return (stat + ((stat * maxEffect) - stat) * (level - min) / (max - min));
}