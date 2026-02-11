import { NextResponse, NextRequest } from 'next/server'
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY!

// Create a service role client that bypasses RLS for public data
const supabase = createClient(supabaseUrl, supabaseServiceKey)

// GET - Fetch all available menu items and categories (public endpoint)
export async function GET(request: NextRequest) {
  try {
    // Fetch categories
    const { data: catData, error: catError } = await supabase
      .from('categories')
      .select('*')
      .order('name')

    if (catError) {
      console.error('Error fetching categories:', catError)
      return NextResponse.json({ error: 'Failed to fetch categories' }, { status: 500 })
    }

    // Fetch menu items with category info
    const { data: itemsData, error: itemsError } = await supabase
      .from('menu_items')
      .select('*, category:categories(*)')
      .eq('is_available', true)
      .order('created_at', { ascending: false })

    if (itemsError) {
      console.error('Error fetching menu items:', itemsError)
      return NextResponse.json({ error: 'Failed to fetch menu items' }, { status: 500 })
    }

    return NextResponse.json({ 
      categories: catData || [],
      menuItems: itemsData || []
    })
  } catch (error) {
    console.error('GET public menu error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
