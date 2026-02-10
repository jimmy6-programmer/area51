"use client"

import React from "react"
import Link from "next/link"
import { usePathname } from "next/navigation"
import Image from "next/image"
import { ShoppingCart, Menu as MenuIcon } from "lucide-react"
import { Button } from "@/components/ui/button"
import { ThemeToggle } from "./theme-toggle"
import { Badge } from "@/components/ui/badge"

export function Navbar({ cartCount = 0, onCartClick }: { cartCount?: number; onCartClick?: () => void }) {
  const pathname = usePathname()

  const navLinks = [
    { href: "/", label: "Home" },
    { href: "/menu", label: "Menu" },
    { href: "/offers", label: "Offers" },
    { href: "/orders", label: "My Orders" },
  ]

  const isActive = (href: string) => {
    if (href === "/") {
      return pathname === "/"
    }
    return pathname.startsWith(href)
  }
  return (
    <nav className="sticky top-0 z-50 w-full border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
      <div className="container mx-auto flex h-16 items-center justify-between px-4">
        <div className="flex items-center gap-4">
          <Link href="/" className="flex items-center space-x-2">
            <div className="relative h-10 w-10 overflow-hidden rounded-full border border-primary">
              <Image
                src="https://slelguoygbfzlpylpxfs.supabase.co/storage/v1/render/image/public/document-uploads/logo3-1770214165568.PNG?width=80&height=80&resize=contain"
                alt="Area 51 Logo"
                fill
                className="object-cover"
              />
            </div>
            <span className="text-xl font-bold tracking-tighter text-primary">AREA 51</span>
          </Link>
        </div>

        <div className="hidden md:flex items-center space-x-6 text-sm font-medium">
          {navLinks.map((link) => (
            <Link
              key={link.href}
              href={link.href}
              className={`transition-colors ${
                isActive(link.href)
                  ? "text-primary font-bold"
                  : "hover:text-primary"
              }`}
            >
              {link.label}
            </Link>
          ))}
        </div>

        <div className="flex items-center space-x-4">
          <ThemeToggle />
          <Button 
            variant="ghost" 
            size="icon" 
            className="relative text-primary hover:bg-primary/10"
            onClick={onCartClick}
          >
            <ShoppingCart className="h-5 w-5" />
            {cartCount > 0 && (
              <Badge className="absolute -top-1 -right-1 h-5 w-5 flex items-center justify-center p-0 text-[10px] bg-primary text-primary-foreground">
                {cartCount}
              </Badge>
            )}
          </Button>
          <Link href="/login">
            <Button variant="outline" className="hidden md:flex border-primary text-primary hover:bg-primary/10">
              Sign In
            </Button>
          </Link>
          <Button className="md:hidden" variant="ghost" size="icon">
            <MenuIcon className="h-5 w-5 text-primary" />
          </Button>
        </div>
      </div>
    </nav>
  )
}
