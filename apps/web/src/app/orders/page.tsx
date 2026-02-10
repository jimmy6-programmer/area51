"use client"

import React from "react"
import { Navbar } from "@/components/navbar"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Separator } from "@/components/ui/separator"
import { motion } from "framer-motion"
import { Clock, CheckCircle2, Package, Truck, XCircle, RefreshCw } from "lucide-react"

type OrderStatus = "pending" | "preparing" | "on_the_way" | "delivered" | "cancelled"

interface Order {
  id: string
  items: { name: string; quantity: number; price: number }[]
  total: number
  status: OrderStatus
  date: string
  deliveryAddress: string
}

const orders: Order[] = [
  {
    id: "ORD-001",
    items: [
      { name: "Alien Burger", quantity: 2, price: 12.99 },
      { name: "Space Fries", quantity: 1, price: 4.99 },
    ],
    total: 30.97,
    status: "on_the_way",
    date: "2026-02-10 14:30",
    deliveryAddress: "123 Main St, City"
  },
  {
    id: "ORD-002",
    items: [
      { name: "Galactic Pizza", quantity: 1, price: 18.99 },
      { name: "Meteor Shake", quantity: 2, price: 6.99 },
    ],
    total: 32.97,
    status: "delivered",
    date: "2026-02-09 19:15",
    deliveryAddress: "456 Oak Ave, Town"
  },
  {
    id: "ORD-003",
    items: [
      { name: "Nebula Wings", quantity: 1, price: 14.99 },
    ],
    total: 14.99,
    status: "cancelled",
    date: "2026-02-08 12:00",
    deliveryAddress: "789 Pine Rd, Village"
  }
]

const statusConfig: Record<OrderStatus, { label: string; icon: React.ReactNode; color: string }> = {
  pending: { label: "Pending", icon: <Clock className="h-4 w-4" />, color: "bg-yellow-500/10 text-yellow-500 border-yellow-500/20" },
  preparing: { label: "Preparing", icon: <RefreshCw className="h-4 w-4" />, color: "bg-blue-500/10 text-blue-500 border-blue-500/20" },
  on_the_way: { label: "On the Way", icon: <Truck className="h-4 w-4" />, color: "bg-primary/10 text-primary border-primary/20" },
  delivered: { label: "Delivered", icon: <CheckCircle2 className="h-4 w-4" />, color: "bg-green-500/10 text-green-500 border-green-500/20" },
  cancelled: { label: "Cancelled", icon: <XCircle className="h-4 w-4" />, color: "bg-red-500/10 text-red-500 border-red-500/20" },
}

export default function OrdersPage() {
  return (
    <div className="min-h-screen bg-background text-foreground selection:bg-primary selection:text-primary-foreground">
      <Navbar onCartClick={() => {}} />
      
      <main className="container mx-auto px-4 py-8">
        <div className="mb-8">
          <h1 className="text-4xl font-bold text-primary mb-2">My Orders</h1>
          <p className="text-muted-foreground">Track and manage your orders</p>
        </div>

        {orders.length === 0 ? (
          <Card className="p-12 text-center">
            <Package className="h-16 w-16 mx-auto text-muted-foreground mb-4" />
            <h2 className="text-xl font-bold mb-2">No orders yet</h2>
            <p className="text-muted-foreground mb-6">Start exploring our menu and place your first order!</p>
            <Button className="bg-primary text-primary-foreground" onClick={() => window.location.href = "/menu"}>
              Browse Menu
            </Button>
          </Card>
        ) : (
          <div className="space-y-6">
            {orders.map((order, index) => {
              const status = statusConfig[order.status]
              return (
                <motion.div
                  key={order.id}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ duration: 0.5, delay: index * 0.1 }}
                >
                  <Card className="border-primary/20 hover:shadow-[0_0_30px_rgba(0,255,0,0.1)] transition-all duration-300">
                    <CardHeader>
                      <div className="flex items-start justify-between">
                        <div>
                          <CardTitle className="text-xl">{order.id}</CardTitle>
                          <CardDescription className="mt-1">{order.date}</CardDescription>
                        </div>
                        <Badge className={`${status.color} flex items-center gap-1`}>
                          {status.icon}
                          {status.label}
                        </Badge>
                      </div>
                    </CardHeader>
                    <CardContent className="space-y-4">
                      <div>
                        <h4 className="text-sm font-medium mb-2">Items</h4>
                        <div className="space-y-2">
                          {order.items.map((item, itemIndex) => (
                            <div key={itemIndex} className="flex justify-between text-sm">
                              <span className="text-muted-foreground">
                                {item.name} x{item.quantity}
                              </span>
                              <span className="font-medium">${(item.price * item.quantity).toFixed(2)}</span>
                            </div>
                          ))}
                        </div>
                      </div>
                      
                      <Separator />
                      
                      <div className="flex justify-between items-center">
                        <div className="text-sm text-muted-foreground">
                          <span className="block">Delivery to: {order.deliveryAddress}</span>
                        </div>
                        <div className="text-lg font-bold text-primary">
                          Total: ${order.total.toFixed(2)}
                        </div>
                      </div>

                      {order.status === "on_the_way" && (
                        <div className="pt-2">
                          <Button className="w-full bg-primary text-primary-foreground">
                            Track Order
                          </Button>
                        </div>
                      )}

                      {order.status === "delivered" && (
                        <div className="pt-2">
                          <Button variant="outline" className="w-full border-primary/20 hover:bg-primary/10">
                            Reorder
                          </Button>
                        </div>
                      )}
                    </CardContent>
                  </Card>
                </motion.div>
              )
            })}
          </div>
        )}
      </main>
    </div>
  )
}
