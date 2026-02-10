export const Button = ({ children }: { children: React.ReactNode }) => {
  return (
    // minimal wrapper — real components should be migrated here when needed
    <button className="px-3 py-1 rounded bg-blue-600 text-white">{children}</button>
  )
}
