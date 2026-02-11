"use client"

import React, { useState, useEffect } from "react"
import Link from "next/link"
import { useRouter } from "next/navigation"
import { Navbar } from "@/components/navbar"
import { useCart } from "@/hooks/use-cart"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Textarea } from "@/components/ui/textarea"
import { Separator } from "@/components/ui/separator"
import { Badge } from "@/components/ui/badge"
import { GooglePlacesAutocomplete } from "@/components/google-places-autocomplete"
import { ShoppingCart, MapPin, Phone, Mail, User, CreditCard, Percent, Check, ArrowLeft, Truck, Clock, Shield, Loader2 } from "lucide-react"
import Image from "next/image"
import { toast } from "sonner"
import { supabase } from "@/lib/supabase"

export default function CheckoutPage() {
  const router = useRouter()
  const { cart, removeFromCart, updateQuantity, totalItems, totalPrice, clearCart } = useCart()
  const [couponCode, setCouponCode] = useState("")
  const [discount, setDiscount] = useState(0)
  const [couponApplied, setCouponApplied] = useState(false)
  const [loading, setLoading] = useState(false)
  const [isAuthenticated, setIsAuthenticated] = useState<boolean | null>(null)

  // Check authentication on mount
  useEffect(() => {
    const checkAuth = async () => {
      const { data: { session } } = await supabase.auth.getSession()
      if (!session) {
        toast.error("Please sign in to checkout")
        router.push("/login")
      } else {
        setIsAuthenticated(true)
      }
    }
    checkAuth()
  }, [router])

  // Show loading state while checking authentication
  if (isAuthenticated === null) {
    return (
      <div className="min-h-screen bg-background text-foreground flex items-center justify-center">
        <div className="text-center">
          <Loader2 className="h-12 w-12 animate-spin text-primary mx-auto mb-4" />
          <p className="text-muted-foreground">Checking authentication...</p>
        </div>
      </div>
    )
  }

  // Redirect if not authenticated
  if (isAuthenticated === false) {
    return null
  }

  // Form state
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    phone: "",
    address: "",
    city: "",
    notes: ""
  })

  const handleCouponApply = () => {
    if (!couponCode.trim()) {
      toast.error("Please enter a coupon code")
      return
    }

    // Simple coupon logic - in a real app, this would be validated against a database
    const coupons: Record<string, { discount: number; description: string }> = {
      "FIRST20": { discount: 0.20, description: "20% off your first order" },
      "WEEKEND": { discount: 0.15, description: "15% weekend discount" },
      "LUNCH": { discount: 0.10, description: "10% lunch combo" },
      "FAMILY15": { discount: 0.15, description: "15% family feast" },
      "AREA51": { discount: 0.25, description: "25% special discount" }
    }

    const coupon = coupons[couponCode.toUpperCase()]
    if (coupon) {
      setDiscount(coupon.discount)
      setCouponApplied(true)
      toast.success(`Coupon applied: ${coupon.description}`)
    } else {
      toast.error("Invalid coupon code")
      setDiscount(0)
      setCouponApplied(false)
    }
  }

  const handleCouponRemove = () => {
    setCouponCode("")
    setDiscount(0)
    setCouponApplied(false)
    toast.info("Coupon removed")
  }

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    })
  }

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)

    // Validate form
    if (!formData.name || !formData.email || !formData.phone || !formData.address || !formData.city) {
      toast.error("Please fill in all required fields")
      setLoading(false)
      return
    }

    // Simulate order submission
    setTimeout(() => {
      toast.success("Order placed successfully! Your food is on the way.")
      clearCart()
      setLoading(false)
      // In a real app, you would redirect to an order confirmation page
    }, 2000)
  }

  const deliveryFee = totalPrice > 30 ? 0 : 5.99
  const discountAmount = totalPrice * discount
  const subtotal = totalPrice
  const finalTotal = subtotal - discountAmount + deliveryFee

  if (cart.length === 0) {
    return (
      <div className="min-h-screen bg-background text-foreground">
        <Navbar cartCount={totalItems} />
        <div className="container mx-auto px-4 py-16">
          <div className="max-w-md mx-auto text-center">
            <div className="h-24 w-24 bg-muted rounded-full flex items-center justify-center mx-auto mb-6">
              <ShoppingCart className="h-12 w-12 text-muted-foreground" />
            </div>
            <h1 className="text-3xl font-bold mb-4">Your cart is empty</h1>
            <p className="text-muted-foreground mb-8">Add some delicious items to your cart before checking out.</p>
            <Link href="/menu">
              <Button className="bg-primary text-primary-foreground">
                Browse Menu
              </Button>
            </Link>
          </div>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-background text-foreground">
      <Navbar cartCount={totalItems} />

      <main className="container mx-auto px-4 py-8">
        {/* Header */}
        <div className="mb-8">
          <Link href="/" className="inline-flex items-center text-sm text-muted-foreground hover:text-primary mb-4 transition-colors">
            <ArrowLeft className="h-4 w-4 mr-2" />
            Back to Home
          </Link>
          <h1 className="text-4xl font-bold tracking-tight mb-2">
            Checkout <span className="text-primary">Mission</span>
          </h1>
          <p className="text-muted-foreground">Complete your order for interstellar delivery</p>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Left Column - Form */}
          <div className="lg:col-span-2 space-y-6">
            {/* Delivery Information */}
            <Card className="border-primary/20 bg-card/50">
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <MapPin className="h-5 w-5 text-primary" />
                  Delivery Information
                </CardTitle>
                <CardDescription>Where should we beam your order?</CardDescription>
              </CardHeader>
              <CardContent>
                <form onSubmit={handleSubmit} className="space-y-4">
                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div className="space-y-2">
                      <Label htmlFor="name" className="flex items-center gap-2">
                        <User className="h-4 w-4" />
                        Full Name <span className="text-destructive">*</span>
                      </Label>
                      <Input
                        id="name"
                        name="name"
                        value={formData.name}
                        onChange={handleInputChange}
                        placeholder="John Doe"
                        required
                      />
                    </div>
                    <div className="space-y-2">
                      <Label htmlFor="phone" className="flex items-center gap-2">
                        <Phone className="h-4 w-4" />
                        Phone Number <span className="text-destructive">*</span>
                      </Label>
                      <Input
                        id="phone"
                        name="phone"
                        type="tel"
                        value={formData.phone}
                        onChange={handleInputChange}
                        placeholder="+1 234 567 8900"
                        required
                      />
                    </div>
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="email" className="flex items-center gap-2">
                      <Mail className="h-4 w-4" />
                      Email Address <span className="text-destructive">*</span>
                    </Label>
                    <Input
                      id="email"
                      name="email"
                      type="email"
                      value={formData.email}
                      onChange={handleInputChange}
                      placeholder="john@example.com"
                      required
                    />
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="address" className="flex items-center gap-2">
                      <MapPin className="h-4 w-4" />
                      Street Address <span className="text-destructive">*</span>
                    </Label>
                    <GooglePlacesAutocomplete
                      id="address"
                      value={formData.address}
                      onChange={(value) => setFormData({ ...formData, address: value })}
                      onSelect={(address) => {
                        setFormData({ ...formData, address })
                        // Auto-fill city from address if possible
                        const parts = address.split(',')
                        if (parts.length > 1) {
                          const cityPart = parts[parts.length - 2].trim()
                          setFormData(prev => ({ ...prev, city: cityPart }))
                        }
                      }}
                      placeholder="Start typing your address..."
                      className="h-10"
                    />
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="city" className="flex items-center gap-2">
                      <MapPin className="h-4 w-4" />
                      City <span className="text-destructive">*</span>
                    </Label>
                    <Input
                      id="city"
                      name="city"
                      value={formData.city}
                      onChange={handleInputChange}
                      placeholder="New York"
                      required
                    />
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="notes">Special Instructions</Label>
                    <Textarea
                      id="notes"
                      name="notes"
                      value={formData.notes}
                      onChange={handleInputChange}
                      placeholder="Any special requests or delivery instructions..."
                      rows={3}
                    />
                  </div>
                </form>
              </CardContent>
            </Card>

            {/* Payment Method */}
            <Card className="border-primary/20 bg-card/50">
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <CreditCard className="h-5 w-5 text-primary" />
                  Payment Method
                </CardTitle>
                <CardDescription>Choose how you want to pay</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-3">
                  <div className="flex items-center justify-between p-4 border border-primary/30 rounded-lg bg-primary/5 cursor-pointer hover:bg-primary/10 transition-colors">
                    <div className="flex items-center gap-3">
                      <div className="h-10 w-10 rounded-full bg-primary/20 flex items-center justify-center">
                        <CreditCard className="h-5 w-5 text-primary" />
                      </div>
                      <div>
                        <p className="font-medium">Cash on Delivery</p>
                        <p className="text-sm text-muted-foreground">Pay when you receive your order</p>
                      </div>
                    </div>
                    <Check className="h-5 w-5 text-primary" />
                  </div>
                  <div className="flex items-center justify-between p-4 border border-border rounded-lg cursor-not-allowed opacity-50">
                    <div className="flex items-center gap-3">
                      <div className="h-10 w-10 rounded-full bg-muted flex items-center justify-center">
                        <CreditCard className="h-5 w-5 text-muted-foreground" />
                      </div>
                      <div>
                        <p className="font-medium">Mobile Payment</p>
                        <p className="text-sm text-muted-foreground">Coming soon</p>
                      </div>
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>

          {/* Right Column - Order Summary */}
          <div className="space-y-6">
            {/* Order Summary */}
            <Card className="border-primary/20 bg-card/50 sticky top-4">
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <ShoppingCart className="h-5 w-5 text-primary" />
                  Order Summary
                </CardTitle>
                <CardDescription>{totalItems} item{totalItems !== 1 ? 's' : ''} in your cart</CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                {/* Cart Items */}
                <div className="space-y-3 max-h-64 overflow-y-auto">
                  {cart.map((item) => (
                    <div key={item.id} className="flex gap-3 items-start">
                      <div className="relative h-16 w-16 rounded-md overflow-hidden border border-border shrink-0">
                        <Image src={item.image} alt={item.name} fill className="object-cover" />
                      </div>
                      <div className="flex-1 min-w-0">
                        <h4 className="font-medium text-sm truncate">{item.name}</h4>
                        <p className="text-xs text-muted-foreground">{item.category}</p>
                        <div className="flex items-center justify-between mt-1">
                          <div className="flex items-center gap-2">
                            <button
                              type="button"
                              onClick={() => updateQuantity(item.id, item.quantity - 1)}
                              className="h-6 w-6 rounded-full border border-primary/20 flex items-center justify-center hover:bg-primary/10 transition-colors"
                            >
                              <span className="text-xs">-</span>
                            </button>
                            <span className="text-sm font-medium w-4 text-center">{item.quantity}</span>
                            <button
                              type="button"
                              onClick={() => updateQuantity(item.id, item.quantity + 1)}
                              className="h-6 w-6 rounded-full border border-primary/20 flex items-center justify-center hover:bg-primary/10 transition-colors"
                            >
                              <span className="text-xs">+</span>
                            </button>
                          </div>
                          <span className="text-sm font-bold text-primary">${(item.price * item.quantity).toFixed(2)}</span>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>

                <Separator />

                {/* Coupon Code */}
                <div className="space-y-2">
                  <Label className="flex items-center gap-2">
                    <Percent className="h-4 w-4" />
                    Coupon Code
                  </Label>
                  {couponApplied ? (
                    <div className="flex items-center justify-between p-3 bg-primary/10 border border-primary/30 rounded-lg">
                      <div className="flex items-center gap-2">
                        <Check className="h-4 w-4 text-primary" />
                        <span className="text-sm font-medium text-primary">{couponCode.toUpperCase()}</span>
                        <Badge variant="outline" className="text-xs">-{(discount * 100).toFixed(0)}%</Badge>
                      </div>
                      <button
                        type="button"
                        onClick={handleCouponRemove}
                        className="text-xs text-muted-foreground hover:text-destructive transition-colors"
                      >
                        Remove
                      </button>
                    </div>
                  ) : (
                    <div className="flex gap-2">
                      <Input
                        value={couponCode}
                        onChange={(e) => setCouponCode(e.target.value)}
                        placeholder="Enter code"
                        className="flex-1"
                      />
                      <Button
                        type="button"
                        variant="outline"
                        onClick={handleCouponApply}
                        className="border-primary/20 text-primary hover:bg-primary/10"
                      >
                        Apply
                      </Button>
                    </div>
                  )}
                </div>

                <Separator />

                {/* Price Breakdown */}
                <div className="space-y-2">
                  <div className="flex justify-between text-sm">
                    <span className="text-muted-foreground">Subtotal</span>
                    <span>${subtotal.toFixed(2)}</span>
                  </div>
                  {discount > 0 && (
                    <div className="flex justify-between text-sm">
                      <span className="text-muted-foreground">Discount ({(discount * 100).toFixed(0)}%)</span>
                      <span className="text-green-500">-${discountAmount.toFixed(2)}</span>
                    </div>
                  )}
                  <div className="flex justify-between text-sm">
                    <span className="text-muted-foreground">Delivery Fee</span>
                    <span>{deliveryFee === 0 ? <span className="text-green-500">FREE</span> : `$${deliveryFee.toFixed(2)}`}</span>
                  </div>
                  <Separator />
                  <div className="flex justify-between text-lg font-bold">
                    <span>Total</span>
                    <span className="text-primary">${finalTotal.toFixed(2)}</span>
                  </div>
                </div>

                {/* Delivery Info */}
                <div className="bg-muted/30 rounded-lg p-3 space-y-2">
                  <div className="flex items-center gap-2 text-sm">
                    <Truck className="h-4 w-4 text-primary" />
                    <span className="text-muted-foreground">Estimated delivery: 30-45 mins</span>
                  </div>
                  <div className="flex items-center gap-2 text-sm">
                    <Clock className="h-4 w-4 text-primary" />
                    <span className="text-muted-foreground">Free delivery on orders over $30</span>
                  </div>
                  <div className="flex items-center gap-2 text-sm">
                    <Shield className="h-4 w-4 text-primary" />
                    <span className="text-muted-foreground">Secure & encrypted payment</span>
                  </div>
                </div>

                {/* Submit Button */}
                <Button
                  type="submit"
                  onClick={handleSubmit}
                  disabled={loading}
                  className="w-full bg-primary text-primary-foreground py-6 text-lg font-bold hover:bg-primary/90 transition-all"
                >
                  {loading ? (
                    <>
                      <span className="animate-pulse">Processing...</span>
                    </>
                  ) : (
                    <>
                      Place Order - ${finalTotal.toFixed(2)}
                    </>
                  )}
                </Button>

                <p className="text-[10px] text-center text-muted-foreground uppercase tracking-widest">
                  By placing this order, you agree to our Terms of Service
                </p>
              </CardContent>
            </Card>
          </div>
        </div>
      </main>
    </div>
  )
}
