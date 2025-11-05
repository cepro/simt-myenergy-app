#!/usr/bin/env python3
"""
Embeds source content into a Flutter web sourcemap.
This allows Sentry to display source code context without needing to fetch source files.
"""

import json
import sys
import os

def embed_sources(sourcemap_path, build_dir):
    """Read sourcemap and embed source content from the build directory."""

    # Load the sourcemap
    with open(sourcemap_path, 'r') as f:
        sourcemap = json.load(f)

    if 'sourcesContent' in sourcemap and sourcemap['sourcesContent']:
        print("Source content already embedded")
        return

    sources = sourcemap.get('sources', [])
    sources_content = []

    print(f"Processing {len(sources)} source files...")

    for source_path in sources:
        content = None

        # Try to find and read the source file
        if source_path.startswith('org-dartlang-sdk:///'):
            # SDK files - we can skip these or mark as unavailable
            content = None
        elif source_path.startswith('/home/'):
            # Absolute path from the build - try to read it
            if os.path.exists(source_path):
                try:
                    with open(source_path, 'r', encoding='utf-8') as sf:
                        content = sf.read()
                except Exception as e:
                    print(f"  Warning: Could not read {source_path}: {e}")
            else:
                # Try relative to build dir
                # Extract the relative part after the project path
                if '/app/lib/' in source_path:
                    rel_path = source_path.split('/app/lib/', 1)[1]
                    try_path = os.path.join(build_dir, 'lib', rel_path)
                    if os.path.exists(try_path):
                        try:
                            with open(try_path, 'r', encoding='utf-8') as sf:
                                content = sf.read()
                        except Exception as e:
                            print(f"  Warning: Could not read {try_path}: {e}")
        elif source_path.startswith('../'):
            # Relative path - resolve relative to build/web directory
            # The sourcemap is in build/web/main.dart.js.map
            # So ../../../lib/actions/actions.dart resolves to lib/actions/actions.dart
            sourcemap_dir = os.path.dirname(os.path.abspath(sourcemap_path))
            abs_source = os.path.normpath(os.path.join(sourcemap_dir, source_path))
            if os.path.exists(abs_source):
                try:
                    with open(abs_source, 'r', encoding='utf-8') as sf:
                        content = sf.read()
                except Exception as e:
                    print(f"  Warning: Could not read {abs_source}: {e}")
            else:
                # Try relative to build directory
                try_path = os.path.join(build_dir, source_path.replace('../', '').replace('./', ''))
                if os.path.exists(try_path):
                    try:
                        with open(try_path, 'r', encoding='utf-8') as sf:
                            content = sf.read()
                    except Exception as e:
                        print(f"  Warning: Could not read {try_path}: {e}")

        sources_content.append(content)

    # Update sourcemap with embedded content
    sourcemap['sourcesContent'] = sources_content

    # Write back to file
    with open(sourcemap_path, 'w') as f:
        json.dump(sourcemap, f)

    # Count how many sources were embedded
    embedded = sum(1 for c in sources_content if c is not None)
    print(f"Embedded {embedded}/{len(sources)} source files")
    print(f"Updated sourcemap: {sourcemap_path}")

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: embed-sources.py <sourcemap-file> <build-dir>")
        print("Example: embed-sources.py build/web/main.dart.js.map /tmp/myenergy-build-xxx")
        sys.exit(1)

    sourcemap_path = sys.argv[1]
    build_dir = sys.argv[2]

    if not os.path.exists(sourcemap_path):
        print(f"Error: Sourcemap not found: {sourcemap_path}")
        sys.exit(1)

    if not os.path.exists(build_dir):
        print(f"Error: Build directory not found: {build_dir}")
        sys.exit(1)

    embed_sources(sourcemap_path, build_dir)
